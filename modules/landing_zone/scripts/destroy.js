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

/**
 * Execute
 * @return {String}
 */
function main() {
  const processes = [];
  const include = [];
  const jsonComponents = JSON.parse(components);

  Object.keys(jsonComponents).forEach(key => include.push(key));

  if (include.length > 0) {
    processes.push(['destroy', '--auto-approve', '--include', include.join(','), '--dependency', 'ignore']);
  }

  try {
    Helper.executeWithErrors(rootPath, 'terrahub', processes);
  } catch (error) {
    throw error;
  }

  return 'Success';
}

(async () => {
  try {
    checkEnvironmentVars();
    Helper.checkIfTerrahubIsInstalled();

    console.log(main());
  } catch (error) {
    console.log(error);
  }
})();
