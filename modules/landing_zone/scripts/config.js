'use strict';

const Helper = require('./helper');

const { ROOT_PATH: rootPath, PROVIDERS: providers, BACKEND: backend, COMPONENTS: components } = process.env;

/**
 * Check if required env variables are defined
 */
function checkEnvironmentVars() {
  if (!rootPath) {
    throw Error('ERROR: ROOT_PATH variable is empty. Aborting...');
  }

  if (!providers) {
    throw Error('ERROR: PROVIDERS variable is empty. Aborting...');
  }

  if (!backend) {
    throw Error('ERROR: BACKEND variable is empty. Aborting...');
  }

  if (!components) {
    throw Error('ERROR: COMPONENTS variable is empty. Aborting...');
  }
}

/**
 * Execute
 * @return {Promise}
 */
async function main() {
  const processes = await Helper.updateConfig(rootPath, providers, backend, components);

  try {
    Helper.removeConfig(rootPath, components);
    Helper.executeWithErrors(rootPath, 'terrahub', processes);
  } catch (error) {
    throw error;
  }

  return 'Success';
}

(async () => {
  try {
    checkEnvironmentVars();
    Helper.checkIsTerrahubAvailable();
    const resp = await main();

    console.log(resp);
  } catch (error) {
    console.log(error);
  }
})();
