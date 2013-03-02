fs  = require('fs')
log = require('logule').init(module, 'HELPER')

class Helper
  createPathTree: (path) ->
    dirs  = path.split('/')
    build = ''

    for dir in dirs
      if dir and dir.split('.').length is 1
        build += "/#{dir}"
        
        unless fs.existsSync(build)
          fs.mkdirSync build
          log.info 'Created directory', build


module.exports = new Helper