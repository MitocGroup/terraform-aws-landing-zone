'use strict';

const Helper = require('./helper');
const { ROOT_PATH: rootPath, COMMAND: command, COMPONENTS: components } = process.env;

/**
 * Check if required env variables are defined
 * @return {Promise}
 */
async function checkEnvironmentVars() {
  if (!rootPath) {
    return Promise.reject(Error('ERROR: ROOT_PATH variable is empty. Aborting...'));
  }

  if (!command) {
    return Promise.reject(Error('ERROR: COMMAND variable is empty. Aborting...'));
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
  const processes = [];
  const include = [];
  const jsonComponents = JSON.parse(components);

  Object.keys(jsonComponents).forEach(key => include.push(key));

  processes.push(['build', '--include', include.join(',')]);
  processes.push(['init', '--include', include.join(',')]);
  processes.push(['apply', '--auto-approve', '--dependency', 'ignore', '--include', include.join(',')]);

  try {
    await Helper.executeWithErrors(rootPath, 'terrahub', processes);
  } catch (error) {
    return Promise.reject(error);
  }

  return Helper.output(include);
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
