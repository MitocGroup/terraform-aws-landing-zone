'use strict';

const Helper = require('./helper');

const { ROOT_PATH: rootPath, COMPONENTS: components } = process.env;

/**
 * Check if required env variables are defined
 * @return {Promise}
 */
async function checkEnvironmentVars() {
  if (!rootPath) {
    return Promise.reject(Error('ERROR: ROOT_PATH variable is empty. Aborting...'));
  }

  if (!components) {
    return Promise.reject(Error('ERROR: COMPONENTS variable is empty. Aborting...'));
  }
}

(async () => {
  try {
    await checkEnvironmentVars();
    await Helper.checkIfTerrahubIsInstalled();
    const resp = await Helper.removeConfig(components, rootPath);
    console.log(resp);
  } catch (error) {
    console.log(error);
  }
})();
