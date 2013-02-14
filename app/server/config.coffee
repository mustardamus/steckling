exports.config = (app, express) ->
  app.configure ->
    app.set 'assets', [
      'app/client/js'
      'app/client/css'
      'app/client/images'
      'vendor/client/js'
      'vendor/client/css'
      'vendor/client/images'
    ]

    app.use express.bodyParser()
    app.use express.methodOverride()

  app.configure 'development', ->
    app.set 'port', 5000
    app.use express.errorHandler({ dumpExceptions: true, showStack: true })

  app.configure 'production', ->
    app.set 'port', 80