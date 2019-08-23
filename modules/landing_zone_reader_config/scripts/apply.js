'use strict';

const Helper = require('./helper');

const { ROOT_PATH: rootPath, BACKEND: backend, COMPONENTS: components } = process.env;

/**
 * Check if required env variables are defined
 * @return {Promise}
 */
async function checkEnvironmentVars() {
  if (!rootPath) {
    return Promise.reject(Error('ERROR: ROOT_PATH variable is empty. Aborting...'));
  }

  if (!backend) {
    return Promise.reject(Error('ERROR: BACKEND variable is empty. Aborting...'));
  }

  if (!components) {
    return Promise.reject(Error('ERROR: COMPONENTS variable is empty. Aborting...'));
  }
}

/**
 * Run terrahub output
 * @param {Array} include
 * @param {JSON} jsonBackend
 */
async function terrahubOutput(include, jsonBackend) {
  let outputMap = [];

  await Helper.executeWithoutErrors(
    'terrahub',
    [
      'configure',
      '--config',
      'component.template.data',
      '--delete',
      '--auto-approve',
      '--include',
      'terrahub_load_outputs'
    ],
    rootPath
  );

  const promises = include.map(async item => {
    await Helper.cli(
      'terrahub',
      ['init', '--include', item],
      rootPath
    );

    const result = await Helper.cli(
      'terrahub',
      ['output', '--format', 'json', '--include', item, '--auto-approve'],
      rootPath
    );

    if (!result.length) {
      throw new Error('No terraform outputs found. Before using `landing_zone_reader` module, '+
        'make sure that `landing_zone` module generates output. Learn more: https://github.com/TerraHubCorp/terraform-aws-landing-zone/');
    }
    
    const outputValues = await extractOutputValues(result, jsonBackend);
    const prepareOutput = `map(${outputValues.join(',')})`;

    outputMap = [...outputMap, ...[prepareOutput]];
  });

  await Promise.all(promises);
  
  await Helper.cli(
    'terrahub',
    [
      'configure',
      '--include',
      'terrahub_load_outputs',
      '--config',
      `component.template.output.terrahub_reader.value=merge(${outputMap.join(',')})`
    ],
    rootPath
  );

  await Helper.cli(
    'terrahub',
    [
      'run',
      '--include',
      'terrahub_load_outputs',
      '--apply',
      '--auto-approve'],
      rootPath
  ); 

  return 'Success';
}

/**
 * Extract output values
 * @param {String} result
 * @param {JSON} jsonBackend
 * @return {Promise<Array>}
 */
async function extractOutputValues(result, jsonBackend) {
  const processes = [];
  let outputMap = [];
  const terrahubConfig = ['configure', '--include', 'terrahub_load_outputs', '--config'];
  const jsonResult = JSON.parse(result);

  Object.keys(jsonResult).forEach(key => {
    processes.push([...terrahubConfig, ...[`component.template.data.terraform_remote_state.${key}.backend=local`]]);
    
    const { backend, bucket, key_prefix } = jsonBackend;

    switch(backend) {
      case 's3':
        const { region } = jsonBackend;
        processes.push([
          ...terrahubConfig,
          ...[
            `component.template.data.terraform_remote_state.${key}` +
              `.backend=s3`
          ]
        ]);
        processes.push([
          ...terrahubConfig,
          ...[
            `component.template.data.terraform_remote_state.${key}` +
              `.config={}`
          ]
        ]);
        processes.push([
          ...terrahubConfig,
          ...[
            `component.template.data.terraform_remote_state.${key}` +
              `.config.bucket=${bucket}`
          ]
        ]);
        processes.push([
          ...terrahubConfig,
          ...[
            `component.template.data.terraform_remote_state.${key}` +
              `.config.region=${region}`
          ]
        ]);
        processes.push([
          ...terrahubConfig,
          ...[
            `component.template.data.terraform_remote_state.${key}` +
              `.config.key=${key_prefix}/${key}/terraform.tfstate`
          ]
        ]);
        break;
      case 'gcs':
        processes.push([
          ...terrahubConfig,
          ...[
            `component.template.data.terraform_remote_state.${key}` +
              `.backend=gcs`
          ]
        ]);
        processes.push([
          ...terrahubConfig,
          ...[
            `component.template.data.terraform_remote_state.${key}` +
              `.config={}`
          ]
        ]);
        processes.push([
          ...terrahubConfig,
          ...[
            `component.template.data.terraform_remote_state.${key}` +
              `.config.prefix=${key_prefix}/${key}`
          ]
        ]);
        break;
      default:
        processes.push([
          ...terrahubConfig,
          ...[
            `component.template.data.terraform_remote_state.${key}` +
              `.config.path=$\{tfvar.terrahub["tfstate_path"]}/${key}/terraform.tfstate`
          ]
        ]);
    }

    Object.keys(jsonResult[key]).forEach(subKey => {
      outputMap = [...outputMap, ...[`"${subKey}"`, `data.terraform_remote_state.${key}.outputs.${subKey}`]];
    });
  });

  try {
    await Helper.executeWithErrors('terrahub', processes, rootPath);
  } catch (error) {
    return Promise.reject(error);
  }

  return outputMap;
}

/**
 * Execute
 * @return {Promise}
 */
async function main() {
  const jsonBackend = JSON.parse(backend);
  const jsonComponents = JSON.parse(components);
  const include = [];

  Object.keys(jsonComponents).forEach(key => include.push(key));

  return terrahubOutput(include, jsonBackend);
}

(async () => {
  try {
    await checkEnvironmentVars();
    await Helper.checkIfTerrahubIsInstalled();
    const resp = await main();
    console.log(resp);
  } catch (error) {
    console.log(error);
  }
})();
