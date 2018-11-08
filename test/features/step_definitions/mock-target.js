
'use strict';

const {Given} = require('cucumber');

Given(/^I use the OAUTH target$/, function(callback) {
    this.apickli.domain = 'https://swiftapi-test.apigee.net/oauth2/v1';
    callback();
});
