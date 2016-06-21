#require user, chromeStorage

setValue = (el, value) ->
  el.val(value)


init =  ->
  @storage = ChromeStorage.get()
  user = new User @storage.get 'currentUser'

  makePrediction()

  self = @
  $('input').click ->
    if not self.currentSelectedInput?
      showSelection user, this
      self.currentSelectedInput = $(this)
    else if self.currentSelectedInput == this
      hideSelection()
      delete self.currentSelectedInput
    else
      hideSelection()
      self.currentSelectedInput = $(this)
      showSelection user, this



showSelection = (user, inputEl) ->
  $('<div/>',
    id: 'fill_user_info_shadow'
  ).css(
    left: "0",
    top: "0",
    position: 'fixed',
    width: "100%",
    height: "100%",
    backgroundColor: 'black',
    opacity: 0.7,
    zIndex: 1023
  ).appendTo 'body'

  $('<div/>',
    id: 'fill_user_info_options'
  ).css(
    left: "30%",
    top: "40%",
    position: 'fixed',
    fontSize: 24,
    zIndex: 1024
  ).append(
    selectOptionElement(user, attr, inputEl) for attr in User.attributeKeys()
  ).appendTo 'body'


hideSelection = ->
  $('#fill_user_info_shadow').remove()
  $('#fill_user_info_options').remove()


selectOptionElement = (user, attr, inputEl) ->
  $('<button/>').attr(
    type: "button",
    value: "#{attr}: #{user.getAttrByName(attr)}"
  ).css(
    left: "30%",
    top: "40%",
    position: 'fixed',
    width: "600px",
    height: "60px",
    fontSize: 24,
    zIndex: 1024
  ).click ->
    optionValue = $(this).val()
    $(inputEl).val(optionValue)
    hideSelection()

makePrediction = ->
  setValue findNameInput(), user.name
  setValue findSurnameInput(), user.surname
  setValue findAddressInput(), user.address
  setValue findPasswordInput(), user.password
  setValue findConfirmPasswordInput(), user.password
  setValue findEmailInput(), user.email

findNameInput = (val) ->

findSurnameInput = (val) ->

findAddressInput = (val) ->

findPasswordInput = (val) ->

findConfirmPasswordInput = (val) ->

findEmailInput = (val) ->


