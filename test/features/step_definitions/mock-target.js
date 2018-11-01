
'use strict';

const {Given} = require('cucumber');



Given(/^I use the OATH target$/, function(callback) {
    this.apickli.domain = 'https://sandbox.swiftlab-api-developer.com/swift-apitracker-pilot/v2';
    callback();
});
