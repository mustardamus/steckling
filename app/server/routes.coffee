exports.routes = (app) ->
  app.get '/', (req, res) ->
    res.send('Pflanz ein Steckling...')