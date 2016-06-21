Object.prototype.amountOfKeys = ->
  return false if this == null or !(getType(this) == 'object')
  Object.keys(this).length


getType = (obj) ->
  Object.prototype.toString.call(obj).match(/^\[object\s(.*)\]$/)[1].toLowerCase()

undefinedToNull = (obj)->
  if obj instanceof Array
    (nullIfUndefined(item) for item in obj)
  else if !obj? or !obj.amountOfKeys()
    nullIfUndefined obj
  else
    obj[key] = nullIfUndefined(value) for key,value of obj
    obj

nullIfUndefined = (item)->
  if (item == undefined or item == "undefined") then null else item
#  alternative way to write it
#  item == undefined or item == "undefined" && null || item

module.exports =
  undefinedToNull: undefinedToNull
