XMLConfigParser = require '../class/XMLConfigParser.coffee'
assert = require 'assert'

describe 'XMLConfigParser', ->
  parser = new XMLConfigParser()
  path = '/home/greyd/darwin/2012_modular/WebContent/WEB-INF/config/sites/diy/home.xml'
  describe 'parse()', ->
    it 'Should parse xml into JSON', (done) ->
      parser.parse '<test class="temp"></test>', (err, data) ->
        if err then return done err
        unless data.test.$.class is 'temp' then return  done 'parsing error'
        done()
  describe 'parseFile', ->
  it 'Should parse xml from file', (done) ->
      parser.parseFile path, (err, data) ->
        if err then return done err
        done()

  describe 'formatPageConfig', ->
    json = null

    before (done) ->
      parser.parseFile path, (err, data) ->
        json = parser.formatJSON data
        done()

    it 'Page should have name', ->
      json.should.have.property 'name'

    it 'Page should have settings', ->
      json.should.have.property 'settings'

    it 'Page should have modules', ->
      json.should.have.property 'modules'

    it 'name should be home', ->
      json.name.should.eql 'home'