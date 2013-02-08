# Steckling - Grow new Apps

## What's this?

This is my 3rd attempt to write a nice Node.js framework. It's the final attempt to create the
development environment of my dreams. Still in development. Always will be.

### Directory structure

  app/

    client/
      collections/
      models/
      views/
      routes.coffee
      init.coffee

    server/
      controllers/
        application.coffee
      models/
      routes.coffee
      init.coffee

    tasks/
    lib/
    vendor/
      client/
      server/
    test/
      client/
      server/

## Todos

  - minimal backend that just serves the index and JSON
  - backbone/mongoose CRUD first
  - what views for frontend?
  - event based on front and backend
  - create app skeleton
  - create collections, models, etc. with prompt
  - frontend mocha TDD
  - create public/assets dir if it does not exist
  - favicon in public dir

## Tricks
  - use SublimeText
  - use livereload with ST plugin

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