module.exports = (app) ->
  schema = app.get('db').Schema
    tasks: Array

  app.get('db').model('Sheet', schema)