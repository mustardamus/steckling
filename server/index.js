var config = {
  routes: {
    '/': ['app', 'public'],
    '/test': 'test'
  },

  // custom asset folders
  // these are available on /assets root url
  // as well on the full path :
  // /assets/init.js
  // /assets/app/init.js
  // are the same files
  assets: [ 
    'app',
    'vendor',
    'test'
  ],

  // from file (can be single or in asset pipeline)
  // compile and minify to js or css
  // to given path

  deploy: {
    'app/js/init.coffee': 'public/assets/bundle.js',
    'vendor/js/jquery.js': 'public/assets/init.js'
  },

  fetch: {
    'http://code.jquery.com/jquery-1.9.1.min.js': 'vendor/js/jquery.js',
    'http://underscorejs.org/underscore-min.js': 'vendor/js/underscore.js'
  },

  controllers: ['']
};

// remove this line and you have a lonely config file
new require('../lib/')(config);