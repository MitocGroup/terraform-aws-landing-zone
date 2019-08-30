'use strict';

const os = require('os');
const { execSync,spawnSync } = require('child_process');

class Helper {
  /**
   * Spawn CLI process
   * @param {String} rootPath
   * @param {String} command
   * @param {Array} args
   * @return {Promise}
   */
  async cli(rootPath, command, args) {
    const execute = spawnSync(command, args, { cwd: rootPath, env: process.env });

    if (execute.status === 0) {
      return execute.stdout.toString();
    }

    return process.env.DEBUG
      ? await Promise.reject(Error(execute.stderr.toString()))
      : Promise.reject(Error(`${command} ${args.join(' ')} failed. Enable DEBUG=debug to learn more.`));
  }

  /**
   * @param {string} rootPath
   * @param {Object} components
   * @return {Promise}
   */
  async removeConfig(rootPath, components) {
    const jsonComponents = JSON.parse(components);
    const terrahubConfig = ['configure', '--config'];

    await this.executeWithoutErrors(rootPath, 'terrahub', [...terrahubConfig, ...['template.tfvars', '-D', '-y']]);
    await this.executeWithoutErrors(rootPath, 'terrahub', [...terrahubConfig, ...['template.terraform', '-D', '-y']]);
    await this.executeWithoutErrors(rootPath, 'terrahub', [...terrahubConfig, ...['template.provider', '-D', '-y']]);
    await this.executeWithoutErrors(rootPath, 'terrahub', [...terrahubConfig, ...['template.provider[0]={}']]);
    await this.executeWithoutErrors(rootPath, 'terrahub', [...terrahubConfig, ...['template.provider[0].aws={}']]);
    await this.executeWithoutErrors(
      rootPath, 'terrahub',
      [...terrahubConfig, ...['template.provider[0].aws.region=var.region']]
    );
    await this.executeWithoutErrors(
      rootPath, 'terrahub',
      [...terrahubConfig, ...['template.provider[0].aws.allowed_account_ids[]=var.account_id']]
    );
    await this.executeWithoutErrors(rootPath, 'terrahub', [...terrahubConfig, ...['template.provider[1]={}']]);
    await this.executeWithoutErrors(rootPath, 'terrahub', [...terrahubConfig, ...['template.provider[1].aws={}']]);
    await this.executeWithoutErrors(
      rootPath, 'terrahub',
      [...terrahubConfig, ...['template.provider[1].aws.alias=default']]
    );
    await this.executeWithoutErrors(
      rootPath, 'terrahub',
      [...terrahubConfig, ...['template.provider[1].aws.region=var.region']]
    );
    await this.executeWithoutErrors(
      rootPath, 'terrahub',
      [...terrahubConfig, ...['template.provider[1].aws.allowed_account_ids[]=var.account_id']]
    );
    await this.executeWithoutErrors(
      rootPath, 'terrahub',
      [...terrahubConfig, ...['template.tfvars.account_id=123456789012']]
    );
    await this.executeWithoutErrors(rootPath, 'terrahub', [...terrahubConfig, ...['template.tfvars.region=us-east-1']]);

    for (const key of Object.keys(jsonComponents)) {
      await this.executeWithoutErrors(
        rootPath, 'terrahub',
        [...terrahubConfig, ...['terraform', '--include', key, '--delete', '--auto-approve']]
      );
    }

    return 'Success';
  }

  /**
   * @param {String} rootPath
   * @param {String} providers
   * @param {String} backends
   * @param {String} components
   * @return {Promise}
   */
  async updateConfig(rootPath, providers, backends, components) {
    const processes = [];
    let index = 1;
    const terrahubConfig = ['configure', '--config'];
    const jsonProviders = JSON.parse(providers);
    const jsonBackends = JSON.parse(backends);
    const jsonComponents = JSON.parse(components);

    const jsonBackendKeysArray = Object.keys(jsonBackends);
    const { backend } = jsonBackends;
    jsonBackendKeysArray.filter(elem => elem !== 'backend').forEach(backendKey => {
      let backendValue = jsonBackends[backendKey];
      if (['key', 'prefix', 'path'].indexOf(backendKey) > -1) {
        backendValue += `/\${tfvar.terrahub["component"]["name"]}` +
          (backend === 'prefix' ? '' : '/terraform.tfstate');
      }
      processes.push([
        ...terrahubConfig,
        ...[`template.terraform.backend.${backend}.${backendKey}=${backendValue}`]
      ]);
    });

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
          rootPath, 'terrahub',
          [...terrahubConfig, ...['terraform', '--delete', '--auto-approve', '--include', key]]
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
   * @param {String} rootPath
   * @param {String} command
   * @param {Array<Array>} argsList
   * @return {Promise}
   */
  async executeWithErrors(rootPath, command, argsList) {
    try {
      argsList.reduce(async (accumulator, args) => {
        await accumulator;
        return this.cli(rootPath, command, args);
      }, Promise.resolve());
    } catch (error) {
      console.log('Error: failed to execute command:');

      return Promise.reject(error);
    }
  }

  /**
   * Execute program and do not throw error
   * @param {String} rootPath
   * @param {String} command
   * @param {Array} args
   * @return {Promise}
   */
  async executeWithoutErrors(rootPath, command, args) {
    try {
      const result = await this.cli(rootPath, command, args);

      console.log(result);
    } catch (error) {
      console.log('Error: failed to execute command: ', error.message);
    }
  }
}

module.exports = new Helper();
