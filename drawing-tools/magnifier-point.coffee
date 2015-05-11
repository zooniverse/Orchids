BaseMagnifierPoint = require 'marking-surface/lib/tools/magnifier-point'

class DetailsMagnifierPoint extends BaseMagnifierPoint
  @Controls: require './fieldset-controls'
  selectedRadius: 60
  
  render: ->
    super
    
    offset = @selectedRadius / @markingSurface.scaleX
    
    @controls.moveTo
      x: @mark.x + offset
      y: @mark.y
    
module.exports = DetailsMagnifierPoint