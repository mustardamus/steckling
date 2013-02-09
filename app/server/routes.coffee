exports.routes = (app) ->
  controllers = [
    'application'  # will be available as @applicationController, etc. (keep scope!)
  ]

  for controller in controllers
    className    = "#{controller}Class"
    ctrlName     = "#{controller}Controller"
    @[className] = require("./controllers/#{controller}")
    @[ctrlName]  = new @[className](app)
      

  app.get '/', (req, res) =>
    @applicationController.routeIndex(req, res)