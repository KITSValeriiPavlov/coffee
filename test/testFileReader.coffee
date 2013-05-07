assert = require 'assert'
FSReader = require '../class/FileReader.coffee'
  
describe 'FSReader', ->
  fsReader = new FSReader()
  
  describe 'read()', ->
    
    it 'Should read file from path setted to function argument', (done) ->
      fsReader.read 'test/fixtures/files/file1.txt', (err, data) ->
        unless err or data is 'file1' then return done('wrong file content')
        done()
        
    it 'Should read files from assigned folder', (done) ->
      fsReader.setDir('test/fixtures/files')
      fsReader.read 'file1.txt', (err, data) ->
        unless err or data is 'file1' then return done('wrong file content')
        done()
        
  describe 'readAll', ->
    
    it 'Should read all files from dir', (done) ->
      fsReader.readAll (err, data) ->
        unless err or data.length is 3 then return done('wrong qty of files')
        done()
