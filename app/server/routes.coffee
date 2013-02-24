exports.routes = (app, express) ->
  controllers = [
    'application'  # will be available as @applicationController, etc. (keep scope!)
    'test'
    'tasks'
    'sheets'
  ]

  for controller in controllers
    className    = "#{controller}Class"
    ctrlName     = "#{controller}Controller"
    @[className] = require("./controllers/#{controller}")
    @[ctrlName]  = new @[className](app)

  crud = (res) =>
    ctrl = @["#{res}Controller"]

    app.get "/#{res}", (req, res) ->
      ctrl.index(req, res)

    app.post "/#{res}", (req, res) ->
      ctrl.create(req, res)

    app.get "/#{res}/:id", (req, res) ->
      ctrl.read(req, res)

    app.put "/#{res}/:id", (req, res) ->
      ctrl.update(req, res)

    app.delete "/#{res}/:id", (req, res) ->
      ctrl.destroy(req, res)
      

  app.get '/', (req, res) =>
    @applicationController.index(req, res)

  app.get '/test', (req, res) =>
    @testController.index(req, res)


  crud 'tasks'
  crud 'sheets'