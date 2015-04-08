BasePoint = require 'zooniverse-readymade/lib/drawing-tools/point'
FieldsetControls = require './fieldset-controls'
PointMark = require './mark'

class Pinpoint extends BasePoint
  @Controls: FieldsetControls
  @Mark: PointMark
  
  constructor: ->
    super
    @disc.attr 'class', 'pinpoint'

  rescale: (scale) ->
    super
  
  coords: (e) ->
    @markingSurface.screenPixelToScale @markingSurface.svg.pointerOffset e

  onMove: (e) =>
    {x, y} = @coords e
    @mark.set {x, y}

  render: ->
    super
    
    offset = @radius / @markingSurface.scaleX
    
    @controls.moveTo
      x: @mark.x + offset
      y: @mark.y

module.exports = Pinpoint