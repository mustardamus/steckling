var coffee = require('coffee-script'),
    _      = require('underscore'),
    Server = require('./server'),
    Tasks  = require('./tasks'),
    config = require('./config').config;

if(process.argv.length === 2) {
  new Server(config);
} else {
  new Tasks(config);
}