# Steckling - Grow new Apps

## What's this?

This is my 3rd attempt to write a nice Node.js framework. It's the final attempt to create the
development environment of my dreams. Still in development. Always will be.

### Application structure
  
    .
    └─ app/                             # application specific files
      └─ client/                        # client specific files
        ├─ images/                      # images, included in /assets
        └─ layouts/                     # layouts served by the server
          └─ default.html               # root url / serves default.html
        └─ css/                         # stylesheets, included in /assets
          ├─ bundle.css.styl            # main css bundle required by default.html
          └─ main.css.styl              # all default styles
        └─ js/                          # javascripts, included in /assets
          ├─ collections/               # backbone collections
          ├─ models/                    # backbone models
          ├─ views/                     # backbone/mustache views
          ├─ bundle.js.coffee           # main js bundle required by default.html
          ├─ init.js.coffee             # define app namespace, start backbone router
          └─ router.js.coffee           # client site routes definitions
      └─ server/                        # server specific files
        └─ controllers/                 # server controllers
          ├─ application.coffee         # main application controller, serves default.html
          └─ test.coffee                # test controller, serves client test suite
        ├─ models/                      # server models
        ├─ init.coffee                  # init server application
        ├─ config.coffee                # server configurations, asset paths
        └─ routes.coffee                # server route definitions


## Tasks

Tasks are stored in the ./tasks directory. The filename is the same as the task name. For example
deploy.coffee is the 'deploy' task.

Each task *must* have a 'run' function as export. 'task' is the reference to the Commander Module, and 'log' to Logule Module:

    exports.run = (task, log) ->

Then run the task:

    steckling deploy -e dev

Create a task template like so:

    steckling new -t task -n taskname

## Automatic Server restart

When any file in ./app/server changes, Forever Module will restart the server. Control it via NPM:

    npm start
    npm stop

To see the log messages start it optionally with Coffee:

    coffee app/server/init.coffee

## Asset Pipeline

Mincer does the asset pipeline.

## Testing

Testing is done with Mocha and Expect, both, on the server and client side.

Run server side test:

    npm test