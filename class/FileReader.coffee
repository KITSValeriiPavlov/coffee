module.exports = class FileReader
  fs = require 'fs'
  async = require 'async'
  constructor : (params) ->
    params ?= {}
    @encoding = params.encoding or 'utf-8'
    @folder = params.folder or null
    
  read : (fileName, callback) ->
    readFile(fileName, @folder, @encoding, callback)
    
  readAll : (args..., callback) ->
    dir = if args.length >= 1 then args[0]  else @folder
    async.waterfall [
      (cb) ->
        fs.readdir dir, cb
      (data, cb) =>
        async.map data, @read, cb
    ], callback
    
  # setters & getters
  getDir : -> @folder
  setDir : (dir) -> @folder = dir
  getEncoding : -> @encoding
  setEncoding : (encoding) -> @encoding = encoding
  
  # private methods
  joinPath = (fileName, dir) ->
    return "#{dir.replace(/(\/|\\)$/, '')}/#{fileName}"
    
  getFileName = (fileName, dir) ->
    return if dir? and dir.length then joinPath(fileName, dir) else fileName
    
  readFile = (fileName, dir, encoding, callback) ->
    fileName = getFileName(fileName, dir)
    fs.readFile(fileName, encoding, callback)