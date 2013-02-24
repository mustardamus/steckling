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

app.get '/test', (req, res) =>
  res.set 'Content-Type', 'text/html'
  res.send """
    <html>
      <head>
        <meta charset="utf-8">
        <title>Mocha Tests</title>
        <link rel="stylesheet" href="/assets/mocha.css" />
      </head>
      <body>
        <div id="mocha"></div>
        <script src="/assets/jquery.js"></script>
        <script src="/assets/expect.js"></script>
        <script src="/assets/mocha.js"></script>

        <script>mocha.setup('bdd');</script>
        
        <script src="/assets/testbundle.js"></script>
        
        <script>mocha.run();</script>
      </body>
    </html>
    """

app.listen app.get('port')
log.info "Server started on port #{app.get('port')}"