'use strict';

const Helper = require('./helper');

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
 * Execute
 * @return {Promise}
 */
async function main() {
  const processes = await Helper.updateConfig(providers, components, rootPath);

  try {
    await Helper.removeConfig(components, rootPath);
    await Helper.executeWithErrors('terrahub', processes, rootPath);
  } catch (error) {
    return await Promise.reject(error);
  }

  return 'Success';
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
