class Menu

  instance = null

  class PrivateClass
    constructor: () ->
      @storage = ChromeStorage
      @users = @storage.getUsers() || []
      @currentUser = @storage.getCurrentUser()

    setCurrentUser: (userId)->
      currentUser = getUser(userId)
      @storage.setCurrentUser(currentUser)

    getCurrentUser: (id) ->
      user = getUser id
      user ||= @users[0]
      @currentUser

    getUser: (id) ->
      for el in arr
        return el if user.id is id

    addUser: (options) ->
      @users << user

    deleteUser: (user) ->
      @users = (currentUser for currentUser in @users when currentUser.id != user.id)


  @get: () ->
    instance ?= new PrivateClass




module.exports = Menu