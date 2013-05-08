module.exports = class XMLConfigParser
  async = require 'async'
  FileReader = require './FileReader'
  XML2JS = require 'xml2js'

  constructor : (options) ->
    if options?
      @parserOptions =
        normalizeTags : options.normalizeTags or true
        normalize : options.normalize or true
        trim : options.trim or true
        explicitArray : options.explicitArray or false
    @init()


  init : ->
    @parser = new XML2JS.Parser()
    @fileReader = new FileReader()
    @

  parse : (xml, callback) =>
    @parser.parseString(xml, callback)

  formatJSON : (json) ->
    page = json.page
    pageAttr = page.$
    pageName = pageAttr.name
    settings = page.settings
    modules = page.modules
    console.log settings
    return {
      name : pageName,
      settings : settings,
      modules : modules
    }


  parseFile : (path, callback) =>
    async.waterfall [
      (callback) =>
        @fileReader.read path, callback
      @parse
    ], callback