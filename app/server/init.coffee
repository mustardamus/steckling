log      = require('logule').init(module, 'SERVER')
express  = require('express')
mincer   = require('mincer')
mongoose = require('mongoose')
config   = require('./config')
routes   = require('./routes')

app = express()
env = new mincer.Environment()

config.config(app, express)

mongoose.connect app.get('dburl')
app.set 'db', mongoose
mongoose.connection.once 'open', ->
  log.info "Connected to MongoDB #{app.get('dburl')}"

routes.routes(app, express)

for path in app.get('assets')
  env.appendPath(path)

app.use '/assets', mincer.createServer(env)
app.use express.static("#{__dirname}/../../public")

app.listen app.get('port')
log.info "Server started on port #{app.get('port')}"