log = require('logule').init(module, 'TEST CONTROLLER')

class testController
  constructor: (app) ->
    @app = app

  index: (req, res) ->
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

module.exports = testController