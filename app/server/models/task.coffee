module.exports = (app) ->
  schema = app.get('db').Schema
    title: String

  app.get('db').model('Task', schema)