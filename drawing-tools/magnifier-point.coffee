BaseMagnifierPoint = require 'marking-surface/lib/tools/magnifier-point'

class MagnifierPoint extends BaseMagnifierPoint
  @Controls: require './fieldset-controls'
  
  render: ->
    super
    
    offset = @selectedRadius / @markingSurface.scaleX
    
    @controls.moveTo
      x: @mark.x + offset
      y: @mark.y
    
module.exports = MagnifierPoint