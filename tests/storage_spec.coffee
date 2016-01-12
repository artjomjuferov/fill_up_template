storages = require '../coffee_files/storage.coffee'
User = require '../coffee_files/user.coffee'

StorageCreator = storages.creator
LocalStorage = storages.local
DevStorage = storages.dev
Storage = storages.storage
fs = require 'fs'


factory = require './factories.coffee'


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

describe.skip "DevStorage", ->

  it 'should have empty storage first', ->
    expect(DevStorage.data).to.be.eql {}
  it 'should have storage path', ->
    expect(DevStorage).to.have.property 'storageFilePath'

  it 'TESTETSTET', ->
    expect(DevStorage).respondTo 'write'


  it 'should have method write()', ->
    expect(DevStorage).to.have.property 'write'
  describe '#write()', ->
    afterEach ->
      deleteFile()

    context 'when the first argument is key and the second is value', ->
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
          expect( @storageData["testValue"] ).to.be.true
        it 'should only override old value, without creating new', ->
          expect( Object.keys(@storageData) ).to.be.length 1
      context 'when only first argument', ->
        before ->
          DevStorage.write "testValue"
          @storageData = getDataFromFile()
        it 'should not created any key', ->
          expect( @storageData  ).to.be.eql {}
      context 'when without arguments', ->
        before ->
          DevStorage.write()
          @storageData = getDataFromFile()
        it 'should not create file', ->
          expect( @storageData  ).to.be.eql {}

  it 'should have method read()', ->
    expect(DevStorage).to.have.property 'read'
  describe '#read()', ->
    context 'when file does not exist', ->
      it 'should throw exception', ->
        expect( -> DevStorage.read("testValue") ).to.throw(Error)
    context 'when without params', ->
      it 'should not return undefined', ->
        expect(DevStorage.read()).to.be.undefined
    context 'when does not exist value', ->
      before ->
        DevStorage.write "foo", true
      it 'should return undefined', ->
        expect(DevStorage.read 'bar').to.be.undefined
    context 'when exist value', ->
      before ->
        DevStorage.write "foo", true
      it 'should return the same', ->
        expect(DevStorage.read 'foo').to.be.true

  it 'should have method updateUser()', ->
    expect(DevStorage).to.have.property 'updateUser'
  describe "#updateUser()", ->
    afterEach ->
      deleteFile()
    context 'when user is correct', ->
      before ->
        @factoryUser
        factory.build 'user', (err, user)->
          @factoryUser = user
        @result = DevStorage.updateUser()
        @storageData = getDataFromFile()
    it "should return true", ->
      expect(@result).to.be.true
    it "should array", ->
      expect(DevStorage.getUser()).to.be.a 'array'

#  it "should has method getUsers()", ->
#    expect(DevStorage).to.have.property 'getUser'
#  describe.skip "#getUsers()", ->
#    it "should return array", ->
#      expect(DevStorage.getUser()).to.be.a 'array'
#    it "should return array of Users attributes", ->
#      expect(DevStorage.getUser()).to.be.a 'array'

#  it "has method getCurrentUser()", ->
#    expect(DevStorageCreator).to.have.property 'get'
