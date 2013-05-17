fs = require('fs')
_  = require('underscore')

class Config
  constructor: ->
    @config   = {}
    @defaults = @readConfig("#{__dirname}/../package.json")
    @custom   = @readConfig("#{process.cwd()}/package.json")

    _.extend @config, @defaults, @custom

  readConfig: (packagePath) ->
    content = fs.readFileSync(packagePath, 'utf-8')
    obj     = JSON.parse(content)

    if obj.steckling
      obj.steckling
    else
      {} # get away easy

module.exports = new Config