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

/**
 * Execute
 * @return {Promise}
 */
async function main() {
  const jsonComponents = JSON.parse(components);
  const terrahubConfig = ['configure', '--config'];

  await Helper.executeWithoutErrors('terrahub', [...terrahubConfig, ...['template.tfvars', '-D', '-y']], rootPath);
  await Helper.executeWithoutErrors('terrahub', [...terrahubConfig, ...['template.provider', '-D', '-y']], rootPath);
  await Helper.executeWithoutErrors('terrahub', [...terrahubConfig, ...['template.provider[0]={}']], rootPath);
  await Helper.executeWithoutErrors('terrahub', [...terrahubConfig, ...['template.provider[0].aws={}']], rootPath);
  await Helper.executeWithoutErrors(
    'terrahub',
    [...terrahubConfig, ...['template.provider[0].aws.region=${var.region}']],
    rootPath
  );
  await Helper.executeWithoutErrors(
    'terrahub',
    [...terrahubConfig, ...['template.provider[0].aws.allowed_account_ids[]=${var.account_id}']],
    rootPath
  );
  await Helper.executeWithoutErrors('terrahub', [...terrahubConfig, ...['template.provider[1]={}']], rootPath);
  await Helper.executeWithoutErrors('terrahub', [...terrahubConfig, ...['template.provider[1].aws={}']], rootPath);
  await Helper.executeWithoutErrors(
    'terrahub',
    [...terrahubConfig, ...['template.provider[1].aws.alias=default']],
    rootPath
  );
  await Helper.executeWithoutErrors(
    'terrahub',
    [...terrahubConfig, ...['template.provider[1].aws.region=${var.region}']],
    rootPath
  );
  await Helper.executeWithoutErrors(
    'terrahub',
    [...terrahubConfig, ...['template.provider[1].aws.allowed_account_ids[]=${var.account_id}']],
    rootPath
  );
  await Helper.executeWithoutErrors(
    'terrahub',
    [...terrahubConfig, ...['template.tfvars.account_id=123456789012']],
    rootPath
  );
  await Helper.executeWithoutErrors('terrahub', [...terrahubConfig, ...['template.tfvars.region=us-east-1']], rootPath);
  await Helper.executeWithoutErrors(
    'terrahub',
    [...terrahubConfig, ...['template.tfvars.tfstate_path=/tmp/.terrahub/tfstate_local/terraform-aws-landing-zone']],
    rootPath
  );

  Object.keys(jsonComponents).forEach(async key => {
    await Helper.executeWithoutErrors(
      'terrahub',
      [...terrahubConfig, ...['terraform', '--include', key, '--delete', '--auto-approve']],
      rootPath
    );
  });

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
