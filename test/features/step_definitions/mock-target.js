
'use strict';

const {Given} = require('cucumber');



Given(/^I use the OAUTH target$/, function(callback) {
    this.apickli.domain = 'https://jerrykickenson-eval-test.apigee.net/oauth';
    callback();
});
