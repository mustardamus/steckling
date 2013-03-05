## Grow a app

### Create a steckling.js

    mkdir steckling-minimal
    cd steckling-minimal
    echo "require('../steckling/lib')();"> steckling.js

### Start it

    node steckling.js

The working directory is empty. Steckling will serve
this readme on localhost:8888 .

### Using the static server

Thre root directory of the steckling.js will be a express
static file server.

Create a direcory and a index file:

    mkdir docs
    echo "Documentation"> docs/index.html

Then you could access the index.html file like this:

    localhost:8888/docs/index.html
    localhost:8888/docs

Index on root level:

    echo "Home"> index.html

Maps to:

    localhost:8888/index.html
    localhost:8888/

### Steckling configuration

Lets extend steckling. In the file steckling.js create a
config object and pass it to steckling

    var config = {
      // configuration here
    };
    require('steckling')(config);

### Custom paths for the static file server

Given we have no index.html on the root path:

    rm index.html

And we want docs/index.html to be served when accessing:

    localhost:8888/

We can map the docs path to the url:

    var config = {
      routes: {
        '/': 'docs'
      }
    };

Now we can access the docs/index.html like:

    localhost:8888/docs/index.html
    localhost:8888/docs
    localhost:8888/index.html
    localhost:8888/

### Asset pipeline

The root path of steckling.js will be served as asset pipeline. Lets
add a javascript file.

    mkdir src
    echo "console.log('home js');"> src/home.js

This file is accessible on:

    localhost:8888/src/home.js
    localhost:8888/assets/src/home.js

### Compile things on the asset pipeling

    rm src/home.js
    echo "console.log 'home coffee'"> src/home.coffee

Uncompiled source code can be served by the static server:

    localhost:8888/src/home.coffee

And compiled code on the asset pipeline:

    localhost:8888/assets/src/home.js
    localhost:8888/assets/src/home.coffee

### Custom asset pipeline paths

    var config = {
      assets: ['src']
    };

And a compiled src/home.coffee wil be served on:

    localhost:8888/assets/home.js
    localhost:8888/assets/home.coffee

### Making use of the asset pipeline

We include the home script in a bundle:

    echo "#= require home"> src/bundle.coffee

And can access that bundle on:

    localhost:8888/assets/bundle.js
    localhost:8888/assets/bundle.coffee
    localhost:8888/assets/src/bundle.js
    localhost:8888/assets/src/bundle.coffee

### Tasks

    node steckling.js list

#### Deploy

Deploy files from the asset pipeline to a single file. Config:

    var config = {
      deploy: {
        'src/bundle.coffee': 'main.js'
      }
    };

Run it via a task:

    node steckling.js deploy

This will write the compiled source code of the bundle to ./main.js

#### Fetch

Fetches files from the web to the disk.

    var config = {
      fetch: {
        'http://code.jquery.com/jquery-1.9.1.min.js': 'vendor/js/jquery.js'
      }
    };

    node steckling.js fetch

### Custom tasks

Custom tasks can be created in the ./tasks directory. The
filename is the task name.

    # ./tasks/hello.coffee

    module.exports =
      description: 'Prints a smiley'
      initialize: (log, config, env) ->
        log.info ':)'

    node steckling hello

### Custom global tasks

You can share tasks for different stecklings by creating
a steckling tasks directory in you $HOME. For example:

    # ~/.config/steckling/tasks/gtask.coffee

    module.exports =
      description: 'A global custom task'
      initialize: (log, config, env) ->
        log.info 'In your home directory: .config/steckling/tasks'

Can now be executed on every steckling:

    node steckling gtask

### Templates