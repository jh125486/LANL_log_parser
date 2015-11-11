ready = ->
  $('.selectpicker').selectpicker 'render'
  UI.all()

$(document).ready ready
$(document).on 'page:load', ready

@equal = (obj1, obj2) ->
  [type_1, type_2] = [typeof obj1, typeof obj2]
  return false unless type_1 is type_2
  if type_1 isnt "object"
    return obj1 is obj2
  else
    if obj1 instanceof Array
      if obj2 instanceof Array
        if obj1.length is obj2.length
          return false for i in [0..obj1.length] when not equal obj1[i], obj2[i]
        else
          return false
      else
        return false
    else
      keys = []
      (keys.push key unless key in keys) for own key, value of obj1
      (keys.push key unless key in keys) for own key, value of obj2
      return false for key in keys when not equal obj1[key], obj2[key]
  true

@equalizeHeights = (selector) ->
  heights = new Array
  $(selector).each ->
    $(@).css 'min-height', '0'
    $(@).css 'max-height', 'none'
    $(@).css 'height', 'auto'
    heights.push $(@).height()
  $(selector).height Math.max.apply(Math, heights)
