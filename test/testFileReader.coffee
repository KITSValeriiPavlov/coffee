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

    it 'Folder path can cotain "/" at the end', (done) ->
      fsReader.setDir('test/fixtures/files/')
      fsReader.read 'file1.txt', (err, data) ->
        unless err or data is 'file1' then return done('"/" at the end of string')
        done()
        
  describe 'readAll', ->
    
    it 'Should read 3 files from dir', (done) ->
      fsReader.readAll (err, data) ->
        unless err or data.length is 3 then return done('wrong qty of files')
        done()

    it 'Files content should be ["file1","file2", "file3"]', (done) ->
      fsReader.readAll (err, data) ->
        unless err or data.join() is 'file1,file2,file3' then done('wrong files content')
        done()