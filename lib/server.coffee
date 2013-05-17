fs       = require('fs')
log      = require('logule').init(module, 'SERVER')
express  = require('express')
mincer   = require('mincer')
_        = require('underscore')
markdown = require('markdown').markdown
Pipeline = require('./pipeline')
defaults = require('./config')

class Server
  constructor: (config) ->
    @app = express()
    @env = (new Pipeline(config)).env
    @opt = _.extend(defaults, config)
    @cwd = process.cwd()

    @app.use '/assets', mincer.createServer(@env)
    @app.use express.static(@cwd)

    @setupStatics()
    @setupHelp()
    @setupCustom()
    @start()    

  setupStatics: ->
    if @opt.routes
      for route, folders of @opt.routes
        folders = [folders] if _.isString(folders)

        for folder in folders
          @app.use route, express.static("#{@cwd}/#{folder}")

  setupHelp: ->
    fs.readdir @cwd, (err, files) =>
      if files.length is 0
        @setupHelpRoute()

  setupHelpRoute: ->
    @app.get '/', (req, res) =>
      root   = "#{__dirname}/.."
      css    = fs.readFileSync("#{root}/vendor/css/kube.css")
      readme = fs.readFileSync("#{root}/README.md", 'utf-8')
      md     = markdown.toHTML(readme)

      res.send """
        <!DOCTYPE HTML>
        <html lang="en">
          <head>
            <meta charset=utf-8>
            <title>Steckling Readme</title>
            <style type="text/css">#{css}</style>
            <style type="text/css">
              #wrapper {
                margin: 80px auto; 
                max-width: 800px;
                _width: 800px;    
              }
              code { border: 0; }
            </style>
          </head>
          <body><div id="wrapper">#{md}</div></body>
        </html>
      """

    log.info "I am a lonely Steckling. See Readme at http://localhost:#{@opt.port}"

  setupCustom: ->
    serverIndex = "#{@cwd}/server/index"

    if fs.existsSync("#{serverIndex}.js") or fs.existsSync("#{serverIndex}.coffee")
      customServer = require(serverIndex)
      customServer.initialize(@app, @env)

  start: ->
    @app.listen @opt.port
    log.info "Server started on port #{@opt.port}"


module.exports = Server