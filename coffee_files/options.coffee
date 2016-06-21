INPUT_LABELS = ['name','surname','password','email','address']

$ ->
  menu = new Menu

  if menu.currentUser?
    changeLabelToUpdateInfo()
    switchUserForEdit menu.currentUser
  else
    changeLabelToAddNew()
    changeLabelToAddNew

  users = menu.users()

  $('#switchUsers').append (userSwitchElement user for user in users)

  $('#updateUserInfo').click (e) ->
    menu.updateCurrentUser createOptionsFromInputs



changeLabelToUpdateInfo = ->
  $('#updateInfo').data('state','update').text('Update user')


changeLabelToAddNew = ->
  $('#updateInfo').data('state','new').text('Create new user')


userSwitchElement = (user) ->
  mainDiv = $('<div>')
  $('<label>').text(user.fullName()).appendTo mainDiv
  $('<button>',
    id: "account#{user.id}",
    data-id: user.id
  ).bind("click", (e) ->
    id = parseInt $(this).data('id')
    switchUserForEdit user
  ).appendTo mainDiv
  mainDiv


switchUserForEdit = (user) ->
  fillInput(input, user.getAttr(input)) for input in INPUT_LABELS
  $('#currentUserLabel').text user.fullName()

fillInput = (input, value) ->
  $("##{input}").val value


createOptionsFromInputs = ->
  options = {}
  for input in INPUT_LABELS
    options[input] = getInputValue input
  options

getInputValue = (input) ->
  $("##{input}").val()