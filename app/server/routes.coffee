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
      

  app.get '/', (req, res) =>
    @applicationController.index(req, res)

  app.get '/test', (req, res) =>
    @testController.index(req, res)


  app.get '/tasks', (req, res) =>
    @tasksController.index(req, res)

  app.post '/tasks', (req, res) =>
    @tasksController.create(req, res)

  app.get '/tasks/:id', (req, res) =>
    @tasksController.read(req, res)

  app.put '/tasks/:id', (req, res) =>
    @tasksController.update(req, res)

  app.delete '/tasks/:id', (req, res) =>
    @tasksController.destroy(req, res)


  app.get '/sheets', (req, res) =>
    @sheetsController.index(req, res)

  app.post '/sheets', (req, res) =>
    @sheetsController.create(req, res)

  app.get '/sheets/:id', (req, res) =>
    @sheetsController.read(req, res)

  app.put '/sheets/:id', (req, res) =>
    @sheetsController.update(req, res)

  app.delete '/sheets/:id', (req, res) =>
    @sheetsController.destroy(req, res)