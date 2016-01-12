class Menu

  constructor: ->
    @users = getFromStorage('users') || []
    @current_user = getFromStorage('current_user_id')

  make_current_user: (user)->
    setInStorage('current_user_id', user.id)

  get_current_user: (id) ->
    _.find @users, (user) -> user.id is id

  setInStorage: (nameInStorage, value) ->
    localStorage[nameInStorage] = value

  getFromStorage: (nameInStorage) ->
    localStorage[nameInStorage]

  @addUser: (user) ->
    @users << user

  @deleteUser: (user) ->
    @users = (currentUser for currentUser in @users when currentUser.id != user.id)

module.exports = Menu