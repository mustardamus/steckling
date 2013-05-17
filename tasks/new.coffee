fs       = require('fs')
_        = require('underscore')
_.str    = require('underscore.string')
log      = require('logule').init(module, 'TEMPLATE')
program  = require('commander')
async    = require('async')
mustache = require('mustache')
helper   = require('../lib/helper')

module.exports =
  description: 'Create a new file from template'
  initialize: (log, config, env) ->
    @templates    = config.templates
    templateName = process.argv[3]
    @cwd         = process.cwd()
    @folders     = [
      "#{__dirname}/../templates"
      "#{process.env['HOME']}/.config/steckling/templates"
      "#{@cwd}/templates"
    ]

    for template, dest of @templates
      if template is templateName
        if _.isArray(dest)
          @buildTemplates dest
        else
          @buildTemplate template, dest, ->
            process.exit()

  buildTemplates: (templates) ->
    callbacks = []

    for tmpl in templates
      do (tmpl) =>
        callbacks.push (cb) =>
          @buildTemplate tmpl, @templates[tmpl], cb

    async.series callbacks, ->
      process.exit()

  buildTemplate: (template, dest, callback = ->) ->
    templatePath = @getTemplatePath(template)

    unless templatePath
      log.error 'Cannot find template', template
      return

    pathVariables = @extractVariables(dest)
    templateSrc   = fs.readFileSync(templatePath, 'utf-8')
    srcVariables  = @extractVariables(templateSrc)

    @promptVariables template, pathVariables, (data) ->
      fullPath = mustache.to_html(dest, data)

      @promptVariables template, srcVariables, (data) ->
        content = mustache.to_html(templateSrc, data)
        
        # do not overwrite
        helper.createPathTree "#{@cwd}/#{fullPath}"
        fs.writeFileSync("#{@cwd}/#{fullPath}", content)
        log.info template, '-->', fullPath
        callback.call @, null, true

  promptVariables: (template, variables, callback) ->
    callbacks = []

    for varName in variables
      do (varName) ->
        callbacks.push (cb) ->
          program.prompt "#{template} - #{varName}: ", (answer) ->
            obj          = {}
            obj[varName] = answer
            cb(null, obj)

    async.series callbacks, (err, results) =>
      flat = {}

      _.extend(flat, result) for result in results
      callback.call @, flat

  getTemplatePath: (template) ->
    ret = []

    for folder in @folders
      continue unless fs.existsSync(folder)

      files = fs.readdirSync(folder)

      for file in files
        split = file.split('.')
        name  = split[0]
        ext   = split[1]

        if name and ext and name is template
          ret.push "#{folder}/#{file}"

    if ret.length
      _.last(ret)
    else
      false

  extractVariables: (content) ->
    split    = content.split('{{')
    varNames = []

    for varName in split
      if varName.indexOf('}}') isnt -1
        varName = varName.split('}}')[0]
        varNames.push _.str.trim(varName)

    _.unique(varNames)