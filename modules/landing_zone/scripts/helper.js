'use strict';

const path = require('path');
const fs = require('fs');
const { spawn } = require('child-process-promise');

class Helper {
  /**
   * Spawn CLI process
   * @param {String} command
   * @param {Array} args
   * @param {String} rootPath
   * @return {Promise}
   */
  async cli(command, args, rootPath) {
    const stdout = [];
    const stderr = [];

    const promise = spawn(command, args, { cwd: rootPath });
    const { childProcess } = promise;

    childProcess.stdout.on('data', data => {
      stdout.push(data);
    });

    childProcess.stderr.on('data', data => {
      if (data.toString() !== '\n') {
        stderr.push(data);
      }
    });

    try {
      await promise;

      return Buffer.concat(stdout).toString();
    } catch (error) {
      error.message = Buffer.concat(stderr).toString();

      if (error) {
        return Promise.reject(Error(error.message));
      }
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
      await Promise.all(argsList.map(args => this.cli(command, args, rootPath)));
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
   * @param {String} include
   * @param {Boolean} compressing
   */
  output(include, compressing) {
    const { ROOT_PATH } = process.env;
    let response = {};

    include.forEach(async item => {
      let result = '';

      try {
        result = await this.cli('terrahub', ['output', '-o', 'json', '-i', item, '-y'], ROOT_PATH);
        response = { ...this.extractOutputValues(result, compressing) };
      } catch (error) {
        console.log('Error: failed to execute command: ', error.message);
      }
    });

    const outputFilePath = path.join(ROOT_PATH, this.outputFileName);

    fs.writeFileSync(outputFilePath, response, { encoding: 'utf-8' });
  }

  /**
   * Extract output values
   * @param result
   * @param compressing
   */
  extractOutputValues(result, compressing) {
    const json = JSON.parse(result);
    let response = {};

    const keys = Object.keys(json);

    keys.forEach(key => {
      const subKeys = Object.keys(json[key]);

      subKeys.forEach(subKey => {
        if (json[key][subKey]['value']) {
          if (compressing) {
            response[subKey] = this.getOutputValueByType(json[key][subKey]['value']);
          } else {
            response[subKey] = json[key][subKey]['value'];
          }
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
