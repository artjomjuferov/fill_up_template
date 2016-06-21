global = require '../coffee_files/global.coffee'
undefinedToNull = global.undefinedToNull


class User
  @addToOptionsKeys: (opts) -> addToOptionsKeys(opts)

  @attributeKeys: -> ['name', 'surname', 'address', 'email', 'password']

  constructor: (options) ->
    options = {} unless options?
    @updateInfo options
    @id = Date.now()


  updateInfo: (options) ->
    options = addToOptionsKeys(options)
    options = undefinedToNull(options)
    { @name, @surname, @address, @email, @password } = options
    @validate()

  validate: ->
    @isValid = true


addToOptionsKeys = (options)->
  options = {} unless options?
  for key in User.attributeKeys
    setKeyToNullIfNo options, key
  options

setKeyToNullIfNo = (object, key)->
  object[key] = null unless object[key]?


module.exports = User


