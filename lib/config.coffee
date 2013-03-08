module.exports =
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