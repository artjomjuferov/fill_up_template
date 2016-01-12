_ = require "underscore"

class User
  constructor: (options) ->
    updateInfo options
    @id = Date.now()

  updateInfo: (options) ->
    { @name, @surname, @address, @email } = options



