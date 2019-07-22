'use strict';

const path = require('path');
const fs = require('fs');
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

    return Promise.reject(Error(execute.stderr.toString()));
  }

  /**
   * Check if terrahub cli is installed
   * @return {Promise}
   */
  async checkIfTerrahubIsInstalled() {
    const platform = os.platform();
    const where = platform === 'win' ? 'where' : 'which';

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

  /**
   * Output data
   * @param {Array} include
   * @return {String}
   */
  output(include) {
    const { ROOT_PATH: rootPath } = process.env;
    let response = {};

    include.forEach(async item => {
      let result = '';

      try {
        result = await this.cli(
          'terrahub',
          ['output', '--format', 'json', '--include', item, '--auto-approve'],
          rootPath
        );

        response = { ...response, ...this.extractOutputValues(result) };

        const outputFilePath = path.join(rootPath, this.outputFileName);

        fs.writeFileSync(outputFilePath, JSON.stringify(response), { encoding: 'utf-8', flag: 'w' });
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

  /**
   * Get name for output file
   * @return {String}
   */
  get outputFileName() {
    return 'output.json';
  }
}

module.exports = new Helper();
