MarkingSurface = require 'marking-surface'

MarkingSurface::rescale = (x, y, width, height) ->
  image = @root.el.querySelector 'g.frames image'
  rect = image.getBoundingClientRect()
  return unless rect.width # rect.width will be 0 if the image is set to display: none
  
  maxWidth = parseInt image.getAttribute 'width'
  maxHeight = parseInt image.getAttribute 'height'
  return unless maxWidth # don't rescale until image has been loaded
  
  # set some sensible defaults for viewbox; current viewbox or subject image dimensions
  currentViewBox = @svg.attr('viewBox')?.split /\s+/
  x ?= parseInt currentViewBox?[0] ? 0
  y ?= parseInt currentViewBox?[1] ? 0
  width ?= parseInt currentViewBox?[2] ? maxWidth
  height ?= parseInt currentViewBox?[3] ? maxHeight
  @svg.attr 'viewBox', [x, y, width, height].join ' '
  rect = image.getBoundingClientRect()
  
  @scaleX = rect.width / maxWidth
  @scaleY = rect.height / maxHeight
  
  # recalculate the viewbox so that the aspect ratio matches the SVG element
  w = parseInt @svg.attr 'width'
  h = parseInt @svg.attr 'height'
  w = w / @scaleX
  h = h / @scaleY
  x = x + .5 * (width - w)
  y = y + .5 * (height - h)
  x = Math.max x, 0
  y = Math.max y, 0
  x = Math.min x, maxWidth - w
  y = Math.min y, maxHeight - h
  @svg.attr 'viewBox', [x, y, w, h].join ' '
  @renderTools()

MarkingSurface.prototype.screenPixelToScale = ({x, y}) ->
  if @svg.el.viewBox.animVal?
    x = x / @scaleX
    y = y / @scaleY
    viewBox = @svg.el.viewBox.animVal
    x += viewBox.x
    y += viewBox.y
  {x, y}

MarkingSurface.prototype.scalePixelToScreen = ({x, y}) ->
  if @svg.el.viewBox.animVal?
    viewBox = @svg.el.viewBox.animVal
    x -= viewBox.x
    y -= viewBox.y
    x = x * @scaleX
    y = y * @scaleY
  {x, y}