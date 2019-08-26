'use strict';

const os = require('os');
const { execSync,spawnSync } = require('child_process');

class Helper {
  /**
   * Spawn CLI process
   * @param {String} command
   * @param {Array} args
   * @param {String} rootPath
   * @return {Promise}
   */
  async cli(command, args, rootPath) {
    const execute = spawnSync(command, args, { cwd: rootPath, env: process.env });

    if (execute.status === 0) {
      return execute.stdout.toString();
    }

    return process.env.DEBUG ? await Promise.reject(Error(execute.stderr.toString())) : Promise.reject(Error('Error occurred!'));
  }

  /**
   * @param {Object} components
   * @param {string} rootPath
   * @return {Promise}
   */
  async removeConfig(components, rootPath) {
    const jsonComponents = JSON.parse(components);
    const terrahubConfig = ['configure', '--config'];

    await this.executeWithoutErrors('terrahub', [...terrahubConfig, ...['template.tfvars', '-D', '-y']], rootPath);
    await this.executeWithoutErrors('terrahub', [...terrahubConfig, ...['template.terraform', '-D', '-y']], rootPath);
    await this.executeWithoutErrors('terrahub', [...terrahubConfig, ...['template.provider', '-D', '-y']], rootPath);
    await this.executeWithoutErrors('terrahub', [...terrahubConfig, ...['template.provider[0]={}']], rootPath);
    await this.executeWithoutErrors('terrahub', [...terrahubConfig, ...['template.provider[0].aws={}']], rootPath);
    await this.executeWithoutErrors(
      'terrahub',
      [...terrahubConfig, ...['template.provider[0].aws.region=var.region']],
      rootPath
    );
    await this.executeWithoutErrors(
      'terrahub',
      [...terrahubConfig, ...['template.provider[0].aws.allowed_account_ids[]=var.account_id']],
      rootPath
    );
    await this.executeWithoutErrors('terrahub', [...terrahubConfig, ...['template.provider[1]={}']], rootPath);
    await this.executeWithoutErrors('terrahub', [...terrahubConfig, ...['template.provider[1].aws={}']], rootPath);
    await this.executeWithoutErrors(
      'terrahub',
      [...terrahubConfig, ...['template.provider[1].aws.alias=default']],
      rootPath
    );
    await this.executeWithoutErrors(
      'terrahub',
      [...terrahubConfig, ...['template.provider[1].aws.region=var.region']],
      rootPath
    );
    await this.executeWithoutErrors(
      'terrahub',
      [...terrahubConfig, ...['template.provider[1].aws.allowed_account_ids[]=var.account_id']],
      rootPath
    );
    await this.executeWithoutErrors(
      'terrahub',
      [...terrahubConfig, ...['template.tfvars.account_id=123456789012']],
      rootPath
    );
    await this.executeWithoutErrors('terrahub', [...terrahubConfig, ...['template.tfvars.region=us-east-1']], rootPath);

    for (const key of Object.keys(jsonComponents)) {
      await this.executeWithoutErrors(
        'terrahub',
        [...terrahubConfig, ...['terraform', '--include', key, '--delete', '--auto-approve']],
        rootPath
      );
    }

    return 'Success';
  }

  /**
   * @param {String} providers
   * @param {String} backends
   * @param {String} components
   * @param {String} rootPath
   * @return {Promise}
   */
  async updateConfig(providers, backends, components, rootPath) {
    const processes = [];
    let index = 1;
    const terrahubConfig = ['configure', '--config'];
    const jsonProviders = JSON.parse(providers);
    const jsonBackends = JSON.parse(backends);
    const jsonComponents = JSON.parse(components);

    const { backend, bucket, key_prefix, region, workspace_key_prefix, path_prefix } = jsonBackends;

    switch(backend) {
      case 's3':
        processes.push([...terrahubConfig, ...[`template.terraform.backend.s3.bucket=${bucket}`]]);
        if (region) {
          processes.push([...terrahubConfig, ...[`template.terraform.backend.s3.region=${region}`]]);
        }
        if (workspace_key_prefix) {
          processes.push([...terrahubConfig, ...[`template.terraform.backend.s3.workspace_key_prefix=${workspace_key_prefix}`]]);
        }
        processes.push([...terrahubConfig, ...[`template.terraform.backend.s3.key=${key_prefix}/\${tfvar.terrahub["component"]["name"]}/terraform.tfstate`]]);
        break;
      case 'gcs':
        processes.push([...terrahubConfig, ...[`template.terraform.backend.gcs.bucket=${bucket}`]]);
        processes.push([...terrahubConfig, ...[`template.terraform.backend.gcs.prefix=${key_prefix}/\${tfvar.terrahub["component"]["name"]}`]]);
        break;
      default:
        processes.push([...terrahubConfig, ...[`template.terraform.backend.local.path=${path_prefix}\${tfvar.terrahub["component"]["name"]}/terraform.tfstate`]]);
    }

    Object.keys(jsonProviders).forEach(key => {
      if (key !== 'default') {
        index += 1;

        const defaultConfig = `template.provider[${index.toString()}]`;

        processes.push([...terrahubConfig, ...[`${defaultConfig}={}`]]);
        processes.push([...terrahubConfig, ...[`${defaultConfig}.aws={}`]]);
        processes.push([...terrahubConfig, ...[`${defaultConfig}.aws.alias=${key}`]]);
        processes.push([...terrahubConfig, ...[`${defaultConfig}.aws.region=var.${key}_region`]]);
        processes.push([...terrahubConfig, ...[`${defaultConfig}.aws.assume_role[0]={}`]]);

        const roleArn = `arn:aws:iam::var.${key}_account_id:role/OrganizationAccountAccessRole`;
        const accountIdConfig = `.aws.assume_role[0].session_name=var.${key}_account_id`;

        processes.push([...terrahubConfig, ...[`${defaultConfig}.aws.assume_role[0].role_arn=${roleArn}`]]);
        processes.push([...terrahubConfig, ...[`${defaultConfig}${accountIdConfig}`]]);
      }

      Object.keys(jsonProviders[key]).forEach(subKey => {
        if (key === 'default') {
          processes.push([...terrahubConfig, ...[`template.tfvars.${subKey}=${jsonProviders[key][subKey]}`]]);
        } else {
          processes.push([...terrahubConfig, ...[`template.tfvars.${key}_${subKey}=${jsonProviders[key][subKey]}`]]);
        }
      });
    });

    await Promise.all(
      Object.keys(jsonComponents).map(key => {
        processes.push([...terrahubConfig, ...[`terraform.varFile[0]=${jsonComponents[key].toString()}`, '-i', key]]);

        return this.executeWithoutErrors(
          'terrahub',
          [...terrahubConfig, ...['terraform', '--delete', '--auto-approve', '--include', key]],
          rootPath
        );
      })
    );

    return processes;
  }


  /**
   * Check if terrahub cli is installed
   * @return {Promise}
   */
  async checkIfTerrahubIsInstalled() {
    const where = os.platform() === 'win32' ? 'where' : 'which';

    try {
      execSync(`${where} terrahub`, { encoding: 'utf8', shell: true, cwd: process.cwd(), stdio: 'ignore' });
    } catch (error) {
      return Promise.reject(Error('terrahub is missing. aborting...'));
    }
  }

  /**
   * Execute program and throw error
   * @param {String} command
   * @param {Array<Array>} argsList
   * @param {String} rootPath
   * @return {Promise}
   */
  async executeWithErrors(command, argsList, rootPath) {
    try {
      argsList.reduce(async (accumulator, args) => {
        await accumulator;
        return this.cli(command, args, rootPath);
      }, Promise.resolve());
    } catch (error) {
      console.log('Error: failed to execute command:');

      return Promise.reject(error);
    }
  }

  /**
   * Execute program and do not throw error
   * @param {String} command
   * @param {Array} args
   * @param {String} rootPath
   * @return {Promise}
   */
  async executeWithoutErrors(command, args, rootPath) {
    try {
      const result = await this.cli(command, args, rootPath);

      console.log(result);
    } catch (error) {
      console.log('Error: failed to execute command: ', error.message);
    }
  }
}

module.exports = new Helper();
