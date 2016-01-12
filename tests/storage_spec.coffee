storages = require '../coffee_files/storage.coffee'
StorageCreator = storages.creator
LocalStorage = storages.local
DevStorage = storages.dev
Storage = storages.storage
fs = require 'fs'

#factory = require './factories.coffee'


describe "StorageCreator", ->
  it "has method get()", ->
    expect(StorageCreator).to.have.property 'getStorage'
  describe "#get()", ->
    context 'when param is local', ->
      it 'should return LocalStorage object', ->
        expect(StorageCreator.getStorage('local')).to.be.an.instanceof LocalStorage
    context 'when param is not set', ->
      it 'should return DevStorage object', ->
        expect(StorageCreator.getStorage()).to.be.an.instanceof DevStorage
    context 'when param is random', ->
      it 'should return DevStorage object', ->
        expect(StorageCreator.getStorage("random_param")).to.be.an.instanceof DevStorage


getDataFromFile = ->
  try
    return JSON.parse(fs.readFileSync(DevStorage.storageFilePath,'utf8'))
  catch err
    throw err

deleteFile = ->
  fs.unlink DevStorage.storageFilePath

describe "DevStorage", ->
  it 'should have method write()', ->
    expect(DevStorage).to.have.property 'write'
  it 'should have empty storage first', ->
    expect(DevStorage.data).to.be.eql {}
  it 'should have storage path', ->
    expect(DevStorage).to.have.property 'storageFilePath'
  describe '#write()', ->
    context 'when first argument key second value', ->
      afterEach ->
        console.log "After called !!"
        deleteFile()
      context 'when empty storage', ->
        before ->
          DevStorage.write "testValue", true
          @storageData = getDataFromFile()
        it 'should write correct value', ->
          expect(@storageData['testValue']).to.be.true
        it 'should write one value at once', ->
          expect(Object.keys(@storageData)).to.be.length 1
      context 'when exist value', ->
        before ->
          DevStorage.write "testValue", false
          DevStorage.write "testValue", true
          @storageData = getDataFromFile()
        it 'should override old value', ->
          expect(@storageData["testValue"]).to.be.true
        it 'should only override old value, without creating new', ->
          expect(Object.keys(@storageData)).to.be.length 1
      context 'when only first argument', ->
        before ->
          DevStorage.write "testValue"
        it 'should not create file', ->
          expect( -> getDataFromFile()).to.throw(Error)
      context 'when without arguments', ->
        before ->
          DevStorage.write()
        it 'should not create file', ->
          expect(-> getDataFromFile()).to.throw(Error)

#  it.skip 'should have method read()', ->
#    expect(Storage).to.have.property 'read'
#    describe '#write()', ->
#      context 'when empty storage', ->
#        it 'should return null', ->
#          expect(Storage.read("testValue")).to.be.eq null
#        context 'when without params', ->
#          it 'should return null ', ->
#            expect(Storage.read("testValue")).to.be.eq null
#      context 'when exist value', ->
#        beforeEach (done)->
#          Storage.write "testValue", true
#        it 'should override old value', ->
#          expect(windows.storage["testValue"]).to.be.eq true
#        it 'should only override old value, without creating new', ->
#          expect(windows.storage.length).to.be.eq 1
#
#  it.skip 'should have method updateUsers()', ->
#    expect(Storage).to.have.property 'updateUsers'
#  describe.skip "#updateUsers()", ->
#    beforeEach ->
#      windows.users = []
#    it "should return array", ->
#      expect(Storage.getUser()).to.be.a 'array'
#    it "should return array of Users attributes", ->
#      expect(Storage.getUser()).to.be.a 'array'

#  it "should has method getUsers()", ->
#    expect(Storage).to.have.property 'getUser'
#  describe.skip "#getUsers()", ->
#    it "should return array", ->
#      expect(Storage.getUser()).to.be.a 'array'
#    it "should return array of Users attributes", ->
#      expect(Storage.getUser()).to.be.a 'array'

#  it "has method getCurrentUser()", ->
#    expect(StorageCreator).to.have.property 'get'
