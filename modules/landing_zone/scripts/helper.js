'use strict';

const fs = require('fs');
const os = require('os');
const path = require('path');
const AWS = require('aws-sdk');
const { execSync, spawnSync } = require('child_process');

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
   * Execute
   * @param {String} rootPath
   * @param {Array} components
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
    let index = 1;
    const processes = [];
    const terrahubConfig = ['configure', '--config'];
    const jsonProviders = JSON.parse(providers);
    const jsonBackends = JSON.parse(backends);
    const jsonComponents = JSON.parse(components);

    const jsonBackendKeysArray = Object.keys(jsonBackends);
    const { backend } = jsonBackends;
    jsonBackendKeysArray.filter(elem => elem !== 'backend').forEach(backendKey => {
      let backendValue = jsonBackends[backendKey];
      if (['key', 'path', 'prefix'].indexOf(backendKey) > -1) {
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

        const roleArn = `arn:aws:iam::\$\{tfvar.terrahub["${key}_account_id"]\}:role/OrganizationAccountAccessRole`;
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

    await this.updateConfigByComponent(jsonComponents, processes, terrahubConfig, rootPath);

    return processes;
  }

  /**
   * @param {Array} jsonComponents
   * @param {Array} processes
   * @param {Array} terrahubConfig
   * @param {String} rootPath
   * @return {Promise}
   */
  async updateConfigByComponent(jsonComponents, processes, terrahubConfig, rootPath) {
    await Promise.all(Object.keys(jsonComponents).map(key => {
      const re = /\s*\/\*\s*/;
      const linkList = jsonComponents[key].split(re);
      if (linkList.length === 1) {
        processes.push([...terrahubConfig, ...[`terraform.varFile[0]=${jsonComponents[key].toString()}`, '-i', key]]);
      }
      else {
        var res = jsonComponents[key].substring(0, 2);
        switch (res) {
          case 's3':
            // @todo s3 ls
            break;
          case 'gs':
            // @todo ls gs
            break;
          case '..':
            fs.readdirSync(path.join(__dirname, '..', linkList[0])).forEach(function (name) {
              processes.push([...terrahubConfig, ...[`terraform.varFile[0]=${path.join(linkList[0], name)}`, '-i', key]]);
            });
            break;
          default:
            fs.readdirSync(path.join(linkList[0])).forEach(function (name) {
              processes.push([...terrahubConfig, ...[`terraform.varFile[0]=${path.join(linkList[0], name)}`, '-i', key]]);
            });
            break;
        }
      }
      return this.executeWithoutErrors(rootPath, 'terrahub', [...terrahubConfig, ...['terraform', '--delete', '--auto-approve', '--include', key]]);
    }));
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
  executeWithErrors(rootPath, command, argsList) {
    argsList.forEach(async args => {
      try {
        const result = await this.cli(
          rootPath, command, args
        );
        console.log(result);
      } catch (error) {
        console.log('Error: failed to execute command:');
        return Promise.reject(error);
      }
    });
    return Promise.resolve();
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

  /**
   * Output data
   * @param {Array} include
   * @return {String}
   */
  output(include) {
    const { ROOT_PATH: rootPath, OUTPUT_PATH: outputPath } = process.env;
    let response = {};

    const outputFileName = path.basename(outputPath);
    const outputFolder = outputPath.replace(outputFileName, '');

    if (!fs.existsSync(outputFolder)) {
      fs.mkdirSync(outputFolder, { recursive: true });
    }

    include.forEach(async item => {
      let result = '';

      try {
        result = await this.cli(
          rootPath, 'terrahub',
          ['output', '--format', 'json', '--include', item, '--auto-approve']
        );

        response = { ...response, ...this.extractOutputValues(result) };

        fs.writeFileSync(outputPath, JSON.stringify(response), { encoding: 'utf-8', flag: 'w' });
      } catch (error) {
        console.log('Error: failed to execute command: ', error.message);
      }
    });

    return 'Success';
  }

  /**
   * Extract output values
   * @param result
   */
  extractOutputValues(result) {
    const json = JSON.parse(result);
    let response = {};

    const keys = Object.keys(json);

    keys.forEach(key => {
      const subKeys = Object.keys(json[key]);

      subKeys.forEach(subKey => {
        if (json[key][subKey]['value']) {
          response[subKey] = json[key][subKey]['value'];
        } else {
          console.log(`Warning: The key ' ${subKey} ' does NOT have any value defined`);
        }
      });
    });

    return response;
  }

  getOutputValueByType(value) {
    if (typeof value === 'string') {
      return value;
    } else if (Array.isArray(value)) {
      return value.join(',');
    }

    const response = [];
    const keys = Object.keys(value);

    keys.forEach(key => response.push(`${key}=${this.getOutputValueByType(value[key])}`));

    return response.join('|');
  }
}

module.exports = new Helper();
