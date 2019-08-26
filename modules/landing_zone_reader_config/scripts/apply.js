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
    rootPath, 'terrahub',
    [
      'configure', '--config', 'component.template.data', '--delete',
      '--auto-approve', '--include', 'terrahub_load_outputs'
    ]
  );

  await Promise.all(
    include.map(async item => {
      await Helper.cli(
        rootPath, 'terrahub',
        ['init', '--include', item]
      );

      const result = await Helper.cli(
        rootPath, 'terrahub',
        ['output', '--format', 'json', '--include', item, '--auto-approve']
      );

      if (!result.length) {
        throw new Error('No terraform outputs found. Before using `landing_zone_reader` module, '+
          'make sure that `landing_zone` module generates output. Learn more: https://github.com/TerraHubCorp/terraform-aws-landing-zone/');
      }

      const outputValues = await extractOutputValues(result, jsonBackend);
      const prepareOutput = `map(${outputValues.join(',')})`;

      outputMap = [...outputMap, ...[prepareOutput]];
    })
  );
  
  await Promise.all(
    await Helper.cli(
      rootPath, 'terrahub',
      [
        'configure', '--include', 'terrahub_load_outputs', '--config',
        `component.template.output.terrahub_reader.value=merge(${outputMap.join(',')})`
      ]
    )
  );

  await Promise.all(
    await Helper.cli(
      rootPath, 'terrahub',
      ['run', '--include', 'terrahub_load_outputs', '--apply', '--auto-approve']
    )
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
    
    const jsonBackendKeysArray = Object.keys(jsonBackend);
    const { backend } = jsonBackend;
    processes.push([
      ...terrahubConfig,
      ...[
        `component.template.data.terraform_remote_state.${key}` +
          `.backend=${backend}`
      ]
    ]);
    processes.push([
      ...terrahubConfig,
      ...[
        `component.template.data.terraform_remote_state.${key}` +
          `.config={}`
      ]
    ]);
    jsonBackendKeysArray.filter(elem => elem !== 'backend').forEach( backendKey => {
      if (backendKey === 'key' || backendKey === 'prefix') {
        jsonBackend[backendKey] += `/${key}` +
          (backend === 's3' ? '/terraform.tfstate' : '');
      }
      processes.push([
        ...terrahubConfig,
        ...[
          `component.template.data.terraform_remote_state.${key}` +
            `.config.${backendKey}=${jsonBackend[backendKey]}`
        ]
      ]);
    });

    Object.keys(jsonResult[key]).forEach(subKey => {
      outputMap = [...outputMap, ...[`"${subKey}"`, `data.terraform_remote_state.${key}.outputs.${subKey}`]];
    });
  });

  try {
    await Helper.executeWithErrors(rootPath, 'terrahub', processes);
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
