exports.routes = (app) ->
  controllers = [
    'application'
  ]

  for controller in controllers
    className    = "#{controller}Class"
    ctrlName     = "#{controller}Controller"
    @[className] = require("./controllers/#{controller}")
    @[ctrlName]  = new @[className](app)
      

  app.get '/', (req, res) =>
    @applicationController.routeIndex(req, res)