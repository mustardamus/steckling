var coffee = require('coffee-script'),
    _      = require('underscore'),
    Server = require('./server'),
    Tasks  = require('./tasks');

module.exports = function(config) {
  if(_.isEmpty(config)) config = {};

  if(process.argv.length === 2) {
    new Server(config);
  } else {
    new Tasks(config);
  }
}