'use strict';

const AWS = require('aws-sdk');

class S3Helper {
  /**
   *
   */
  constructor() {
    this._s3 = new AWS.S3();
  }

  /**
   * Get s3 object
   * @param {String} bucketName
   * @param {String} objectKey
   * @returns {Promise}
   */
  async getObject(bucketName, objectKey) {
    return this._s3.listObjects({ Bucket: bucketName, Delimiter: '/', Prefix: objectKey }).promise();
  }
}

module.exports = S3Helper;
