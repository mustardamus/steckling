# Steckling - Flexible Front End Dev Server

## Features

- no configuration http server and asset pipeline
- can execute tasks
- write your own tasks
- can fetch files from the web
- can create files from templates via prompt
- can deploy files from the asset pipeline

## Install

    npm install steckling

## Start a development server

    steckling

## List all tasks

    steckling list

## Static file server

The whole directory you started steckling on will be served as a static file server.

Let's create a file: `docs/index.html`

    <!DOCTYPE HTML>
    <html lang="en">
      <head>
        <title>Docs</title>
      </head>
      <body>
        ...
      </body>
    </html>

Now this file now can be served on `localhost:7777/docs/index.html`. And since its a
`index.html` also on `localhost:7777/docs`.

## Asset pipeline

The Steckling directory is not only a file server but also a asset pipeline which will be served on
`localhost:7777/assets`.

Let's create another file: `src/home.js`

    console.log('home file');

You already know that you could serve that file with the file server on `localhost:7777/src/home.js`.

But we can access JS files with the asset pipeline too on `localhost:7777/assets/src/home.js`.

### Compile CoffeeScript

Hey, you want to write your code in CoffeeScript? Let's create another file: `src/nav.coffee`

    console.log 'nav file'

Now that uncompiled file can be accessed on the file server `localhost:7777/src/nav.coffee`.

The compiled JavaScript is accessible on the asset pipeline. `localhost:7777/assets/src/nav.coffee`
and `localhost:7777/assets/src/nav.js`.

### Asset bundles

We want to merge our two JS files together. No problem with the asset pipeline.

Let's create bundle: `src/bundle.js`

    //= require ./home
    //= require ./nav

Now you can access that compiled and merged bundle of `home.js` and `nav.coffee` on
`localhost:7777/src/bundle.js`. Simple as that to structure your JS and CSS projects.

## Configuration

A configuration object can be passed to Steckling. Let's update `steckling.js`:

    var config = {};
    require('steckling')(config);

### Add custom paths to static file server

You easily can add custom paths to the default static file server.

    var config = {
      routes: {
        '/'    : 'docs',             // map docs folder to root url
        '/test': ['spec', 'specs']   // map spec and specs folder to /test path
      }
    };

This would result in the following urls:

    localhost:777/docs/index.html
    localhost:777/docs/
    localhost:777/index.html
    localhost:777/

    localhost:777/test/index.html
    localhost:777/test

### Add custom paths to the asset pipeline

You can map folders to the root url of the asset pipeline.

    var config = {
      assets: ['src', 'vendor']
    };

Would result in these urls:

    localhost:7777/assets/src/nav.coffee
    localhost:7777/assets/src/nav.js
    localhost:7777/assets/nav.coffee
    localhost:7777/assets/nav.js

## Tasks
### Global tasks

## Templates
### Global templates

    steckling new task         # creates a new task sceleton in ./tasks
    steckling new package      # creates a basic package.json in ./

## Fetch

## Deploy

## Custo Node.js server

You could include your own Node.js server. Just have a `index.js` or `index.coffee` in the
directory `server/`:

    module.exports =
      initialize: (app, env, express) ->
        app.get '/custom', (req, res) ->
          res.send 'route'


## The `package.json` file

You can overwrite/extend steckling's configuration in `package.json` like so:

    {
      "name"       : "myapp",
      "description": "mydesc",
      "version"    : "0.0.1",
      "steckling": {
        "port": 7777,
        "routes": {},
        "assets": [],
        "deploy": {},
        "fetch": {}
      }
    }

What the different options will do:

    # port to run the development server on
    port: 7777

    # directories to be exposed to the static server
    # by default all files of the root folder are served as public
    # 
    # '/'    : 'docs'            # map docs folder to /
    # '/test': ['spec', 'oth']   # map spec and test folder to /test
    #
    # /docs/docs.html            
    # /docs.html
    #
    # /test/spec.html
    # /spec/spec.html
    # /oth/oth.html
    # /test/oth.html
    routes: {}

    # directories to be compiled and served on /assets
    # by default all files of the root folder are assets
    # ['src', 'vendor', 'vendor/js']
    #
    # /assets/src/plugin.coffee
    # /assets/plugin.coffee
    # /asssts/plugin.js
    #
    # /assets/vendor/js/jquery.js
    # /assets/vendor/jquery.js
    # /assets/jquery.js
    assets: []

    # compile files from the asset pipeline to disk
    # 'src/plugin.coffee'  : 'dest/plugin.js'
    # 'vendor/js/jquery.js': ['dest/jquery.js', 'docs/js/jquery.js']
    deploy: {}

    # fetch files from url and write them to disk
    # 'http://code.jquery.com/jquery-1.9.1.min.js': 'vendor/js/jquery.js'
    # 'http://imperavi.com/css/kube.min.css'      : 'vendor/css/kube.css'
    fetch: {}

## To-Do

- finish readme
- public/