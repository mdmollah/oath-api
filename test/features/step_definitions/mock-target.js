
'use strict';

const {Given} = require('cucumber');

Given(/^I use the OAUTH target$/, function(callback) {
    this.apickli.domain = 'https://sandbox.swift.com/oauth2/v1';
    callback();
});
