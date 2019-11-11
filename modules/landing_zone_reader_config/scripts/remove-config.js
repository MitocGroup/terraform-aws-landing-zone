'use strict';

const Helper = require('./helper');

const { ROOT_PATH: rootPath, COMPONENTS: components } = process.env;

/**
 * Check if required env variables are defined
 */
function checkEnvironmentVars() {
  if (!rootPath) {
    throw Error('ERROR: ROOT_PATH variable is empty. Aborting...');
  }

  if (!components) {
    throw Error('ERROR: COMPONENTS variable is empty. Aborting...');
  }
}

(async () => {
  try {
    checkEnvironmentVars();
    Helper.checkIfTerrahubIsInstalled();

    console.log(Helper.removeConfig(rootPath, components));
  } catch (error) {
    console.log(error);
  }
})();
