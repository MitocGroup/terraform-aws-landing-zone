'use strict';

const Helper = require('./helper');
const commandExists = require('command-exists');

const { ROOT_PATH: rootPath, PROVIDERS: providers, COMPONENTS: components } = process.env;

/**
 * Check if required env variables are defined
 * @return {Promise}
 */
async function checkEnvironmentVars() {
  if (!rootPath) {
    return Promise.reject(Error('ERROR: ROOT_PATH variable is empty. Aborting...'));
  }

  if (!providers) {
    return Promise.reject(Error('ERROR: PROVIDERS variable is empty. Aborting...'));
  }

  if (!components) {
    return Promise.reject(Error('ERROR: COMPONENTS variable is empty. Aborting...'));
  }
}

/**
 * Check if terrahub cli is installed
 * @return {Promise}
 */
async function checkIfTerrahubIsInstalled() {
  try {
    await commandExists('terrahub');
  } catch (error) {
    return Promise.reject(Error('terrahub is missing. aborting...'));
  }
}

/**
 * Execute
 * @return {Promise}
 */
async function main() {
  const processes = [];

  let index = 1;
  const terrahubConfig = ['configure', '--config'];
  const jsonProviders = JSON.parse(providers);
  const jsonComponents = JSON.parse(components);

  Object.keys(jsonProviders).forEach(key => {
    if (key !== 'default') {
      index += 1;

      const defaultConfig = `template.provider[${index.toString()}]`;

      processes.push([...terrahubConfig, ...[defaultConfig + '={}']]);
      processes.push([...terrahubConfig, ...[defaultConfig + '.aws={}']]);
      processes.push([...terrahubConfig, ...[defaultConfig + '.aws.alias=' + key]]);
      processes.push([...terrahubConfig, ...[defaultConfig + '.aws.region=${var.' + key + '_region}']]);
      processes.push([...terrahubConfig, ...[defaultConfig + '.aws.assume_role[0]={}']]);

      const roleArn = 'arn:aws:iam::${var.' + key + '_account_id}:role/OrganizationAccountAccessRole';
      const accountIdConfig = '.aws.assume_role[0].session_name=${var.' + key + '_account_id}';

      processes.push([...terrahubConfig, ...[defaultConfig + '.aws.assume_role[0].role_arn=' + roleArn]]);
      processes.push([...terrahubConfig, ...[defaultConfig + accountIdConfig]]);
    }

    Object.keys(jsonProviders[key]).forEach(subKey => {
      if (key === 'default') {
        processes.push([...terrahubConfig, ...['template.tfvars.' + subKey + '=' + jsonProviders[key][subKey]]]);
      } else {
        processes.push([...terrahubConfig, ...['template.tfvars.' + key + '_' + subKey + jsonProviders[key][subKey]]]);
      }
    });
  });

  await Promise.all(
    Object.keys(jsonComponents).map(key => {
      processes.push([...terrahubConfig, ...['terraform.varFile[0]=' + jsonComponents[key].toString(), '-i', key]]);

      return Helper.executeWithoutErrors(
        'terrahub',
        [...terrahubConfig, ...['terraform', '--delete', '--auto-approve', '--include', key]],
        rootPath
      );
    })
  );

  try {
    await Helper.executeWithErrors('terrahub', processes, rootPath);
  } catch (error) {
    return Promise.reject(error);
  }

  return 'Success';
}

(async () => {
  try {
    await checkEnvironmentVars();

    await checkIfTerrahubIsInstalled();

    const resp = await main();

    console.log(resp);
  } catch (error) {
    console.log(error);
  }
})();
