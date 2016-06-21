fs = require 'fs'

class StorageCreator
  @getStorage: (type) ->
    switch type
      when "local" then new LocalStorage()
      else new DevStorage()


class Storage

  @set: (nameInStorage, value, callback=undefined) ->
    return false if !nameInStorage? or !value?
    try
      write nameInStorage, JSON.stringify(value), callback
    catch err
      return false
    return true

  @get: (nameInStorage) ->
    return unless nameInStorage?
    try
      JSON.parse(read nameInStorage)
    catch err
      return



class ChromeStorage extends Storage
  instance = null

  class PrivateClass
    write: (nameInStorage, value, callback) ->
      chrome.storage.sync.set({nameInStorage: value}, callback)
    read: (nameInStorage) ->
      self = @
      chrome.storage.sync.get nameInStorage, (value)->
        self.gottenValue = value
      @gottenValue

  @get: () ->
    instance ?= new PrivateClass



class LocalStorage extends Storage
  @write: (nameInStorage, value) ->
    localStorage[nameInStorage] = value
  @read: (nameInStorage) ->
    localStorage[nameInStorage]

  @updateStorage: ->
    try
      fs.writeFileSync @storageFilePath, JSON.stringify(@data)
    catch err
      throw err

  @updateData: ->
    try
      @data = JSON.parse(fs.readFileSync @storageFilePath, 'utf8')
    catch err
      throw err


class DevStorage extends Storage
  @storageFilePath = 'devStorage.json'

  @updateStorage: ->
    try
      fs.writeFileSync @storageFilePath, JSON.stringify(@data)
    catch err
      throw err

  @updateData: ->
    try
      @data = JSON.parse(fs.readFileSync @storageFilePath, 'utf8')
    catch err
      throw err





module.exports =
  creator: StorageCreator,
  local: LocalStorage,
  storage: Storage,
  dev: DevStorage
