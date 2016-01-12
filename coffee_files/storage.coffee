fs = require 'fs'

class StorageCreator
  @getStorage: (type) ->
    switch type
      when "local" then new LocalStorage()
      else new DevStorage()



class Storage
  @data = {}

  @write: (nameInStorage, value) ->
    return false if !nameInStorage? or !value?
    @data[nameInStorage] = value
    @updateStorage()
    return true

  @read: (nameInStorage) ->
    @updateData() if nameInStorage?
    return @data[nameInStorage]


class LocalStorage extends Storage
  @write: (nameInStorage, value) ->
    localStorage[nameInStorage] = value
  @read: (nameInStorage) ->
    localStorage[nameInStorage]


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

class SqlStorage extends Storage
  @write: (nameInStorage, value) ->
    localStorage[nameInStorage] = value
  @read: (nameInStorage) ->
    localStorage[nameInStorage]


class ChromeStorage extends Storage
  @write: (nameInStorage, value) ->
    localStorage[nameInStorage] = value
  @read: (nameInStorage) ->
    localStorage[nameInStorage]

module.exports =
  creator: StorageCreator,
  local: LocalStorage,
  storage: Storage,
  dev: DevStorage
