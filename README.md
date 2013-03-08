# Steckling - Flexible Front End Dev Server

## Features

- one file for configuration and invokation
- has a extendible static file server
- has a extendible asset pipeline
- can execute tasks, write your own tasks
- can fetch files from the web
- can create files from templates via prompt
- can deploy files from the asset pipeline

## Install

    npm install steckling -g

## The `steckling.js` file

Or name it as you want. In this file you can configure Steckling and have to invoke the module to
make it work. The configuration only applys to the folder where `steckling.js` resides. 

A minimal setup would be:

    require('steckling')();

Lets start it:

    ❯ node steckling.js
    22:54:02 - INFO  - SERVER - Server started on port 7777
    22:54:02 - INFO  - SERVER - I am a lonely Steckling. See Readme at http://localhost:7777

If there are no files in the current directory except `steckling.js` then this readme will be
served on localhost. Nicely formated.

## Static file server

The whole directory you started `steckling.js` on will be served as a static file server.

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

## Fetch

## Deploy

## To-Do

- finish readme