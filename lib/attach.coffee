factory = ($) ->
  (el, [elX, elY] = [0.5, 0.5], to = document.body, [toX, toY] = [0.5, 0.5], {margin} = {}) ->
    el = $(el)
    throw new Error 'Couldn\'t find an element to attach.' if el.length is 0

    to = $(to).filter(':visible').first()
    to = $(window) if to.length is 0

    margin ?= 0

    positions =
      left: 0, center: 0.5, right: 1
      top: 0, middle: 0.5, bottom: 1

    elX = positions[elX] if elX of positions
    elY = positions[elY] if elY of positions
    toY = positions[toY] if toY of positions
    toX = positions[toX] if toX of positions

    toSize =
      width: to.outerWidth() + (margin * 2)
      height: to.outerHeight() + (margin * 2)

    toOffset = to.offset() || left: 0, top: 0
    toOffset.top -= margin
    toOffset.left -= margin

    elSize =
      width: el.outerWidth()
      height: el.outerHeight()

    newElOffset =
      left: toOffset.left - (elSize.width * elX) + (toSize.width * toX)
      top: toOffset.top - (elSize.height * elY) + (toSize.height * toY)

    el.offset newElOffset

if define?.amd
  define ['jquery'], factory
else
  jQuery = window.jQuery

  if module?.exports
    module.exports = factory jQuery
  else
    window.zootorial ?= {}
    window.zootorial.attach = factory jQuery
