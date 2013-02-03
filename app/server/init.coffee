log     = require('logule').init(module, 'SERVER')
express = require('express')
mincer  = require('mincer')
config  = require('./config')
routes  = require('./routes')

app = express()
env = new mincer.Environment()

config.config(app)
routes.routes(app)

for path in app.get('assets')
  env.appendPath(path)

app.use '/assets', mincer.createServer(env)
app.use express.static("#{__dirname}/../../public")

app.listen app.get('port')
log.info "Server started on port #{app.get('port')}"