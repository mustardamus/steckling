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
### Tasks
### Templates