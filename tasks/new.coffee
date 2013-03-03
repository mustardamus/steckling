###
fs      = require('fs')
_       = require('underscore')
_.str   = require('underscore.string')
log     = require('logule').init(module, 'TEMPLATE')
program = require('commander')
async   = require('async')
helper  = require('./helper')

class Templates
  constructor: (config) ->
    templateName = process.argv[3]

    for template, dest of config.templates
      do (template, dest) =>
        varNames = @readVariables(dest)

        @promptVariables varNames, (result) =>
          @buildTemplate(template, dest, result)

  readVariables: (content) ->
    split    = content.split('<%=')
    varNames = []

    for varName in split
      if varName.indexOf('%>') isnt -1
        varName = varName.split('%>')[0]
        varNames.push _.str.trim(varName)

    _.unique(varNames)

  promptVariables: (varNames, callback) ->
    callbacks = []

    for varName in varNames
      do (varName) ->
        callbacks.push (cb) ->
          program.prompt "#{varName}: ", (answer) ->
            obj          = {}
            obj[varName] = answer
            cb(null, obj)

    async.series callbacks, (err, results) =>
      flat = {}

      _.extend(flat, result) for result in results
      callback(flat)

  buildTemplate: (template, dest, info) ->
    dest     = _.template(dest)
    dest     = dest(info)
    cwd      = process.cwd()
    tmplPath = "#{cwd}/templates/#{template}"

    content  = fs.readFileSync(tmplPath, 'utf-8')
    varNames = @readVariables(content)

    @promptVariables varNames, (result) ->
      tmpl = _.template(content)
      tmpl = tmpl(result)
      
      # do not overwrite
      helper.createPathTree "#{cwd}/#{dest}"
      fs.writeFileSync("#{cwd}/#{dest}", tmpl);
      log.info template, '-->', dest
      process.exit()


module.exports = Templates
###