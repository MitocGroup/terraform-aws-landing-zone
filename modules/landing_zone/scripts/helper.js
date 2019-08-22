'use strict';

const path = require('path');
const fs = require('fs');
const os = require('os');
const { execSync, spawnSync } = require('child_process');

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
   * Execute
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
    await this.executeWithoutErrors(
      'terrahub',
      [...terrahubConfig, ...['template.tfvars.tfstate_path=/tmp/.terrahub/tfstate_local/terraform-aws-landing-zone']],
      rootPath
    );

    for (const key of Object.keys(jsonComponents)) {
      await this.executeWithoutErrors(
        'terrahub',
        [...terrahubConfig, ...['terraform', '--include', key, '--delete', '--auto-approve']],
        rootPath
      );
      await this.executeWithoutErrors(
        'terrahub',
        [...terrahubConfig, ...['component.template.terraform.backend', '--include', key, '--delete', '--auto-approve']],
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

    const { backend, bucket, key_prefix } = jsonBackends;

    switch(backend) {
      case 's3':
        const { region, workspace_key_prefix } = jsonBackends;
        processes.push([...terrahubConfig, ...[`template.tfvars.tfstate_key_prefix=${key_prefix}`]]);
        processes.push([...terrahubConfig, ...[`template.terraform.backend.s3.bucket=${bucket}`]]);
        processes.push([...terrahubConfig, ...[`template.terraform.backend.s3.region=${region}`]]);
        processes.push([...terrahubConfig, ...[`template.terraform.backend.s3.workspace_key_prefix=${workspace_key_prefix}`]]);
        Object.keys(jsonComponents).map(key => {
          processes.push([...terrahubConfig, ...[`component.template.terraform.backend.s3.key=\${tfvar.terrahub["tfstate_key_prefix"]}/${key}/terraform.tfstate`, '--include', key]]);
        });
        break;
      case 'gcs':
        processes.push([...terrahubConfig, ...[`template.tfvars.tfstate_key_prefix=${key_prefix}`]]);
        processes.push([...terrahubConfig, ...[`template.terraform.backend.gcs.bucket=${bucket}`]]);
        Object.keys(jsonComponents).map(key => {
          processes.push([...terrahubConfig, ...[`component.template.terraform.backend.gcs.prefix=\${tfvar.terrahub["tfstate_key_prefix"]}/${key}`, '--include', key]]);
        });
        break;
      default:
        const { path_prefix } = jsonBackends;
        processes.push([...terrahubConfig, ...[`template.tfvars.tfstate_path=${path_prefix}`]]);
        Object.keys(jsonComponents).map(key => {
          processes.push([...terrahubConfig, ...[`component.template.terraform.backend.local.path=\${tfvar.terrahub["tfstate_path"]}/${key}/terraform.tfstate`, '--include', key]]);
        });
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
  executeWithErrors(command, argsList, rootPath) {
    argsList.forEach(async args => {
      try {
        const result = await this.cli(
          command, args, rootPath
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
          'terrahub',
          ['output', '--format', 'json', '--include', item, '--auto-approve'],
          rootPath
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
