exports.config = (app) ->
  app.configure ->
    app.set 'assets', [
      'app/client/js'
      'app/client/css'
      'app/client/images'
      'vendor/client/js'
      'vendor/client/css'
      'vendor/client/images'
    ]

  app.configure 'development', ->
    app.set 'port', 5000

  app.configure 'production', ->
    app.set 'port', 80