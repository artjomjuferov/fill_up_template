class User
  constructor: (options) ->
    options = {} unless options?
    @updateInfo options
    @id = Date.now()

  updateInfo: (options) ->
    { @name, @surname, @address, @email, @password } = options
    @validate()

  validate: ->
    @isValid = true


module.exports = User


