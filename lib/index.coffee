multer = require 'multer'

configFn = require 'a-http-server-config-fn'

{ existsSync } = require 'fs'

{ sync: mkdirSync } = require 'mkdirp'

module.exports = (next) ->

  configFn @config, "#{__dirname}/config"

  process.on "a-http-server:shutdown:dettach", () ->

    process.emit "a-http-server:shutdown:dettached", "upload"

  dir = @config.plugins.upload.dest

  if not existsSync dir then  mkdirSync dir

  @app.use multer @config.plugins.upload

  process.emit "a-http-server:shutdown:attach", "upload"

  next null
