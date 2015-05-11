BaseMagnifierPoint = require 'marking-surface/lib/tools/magnifier-point'

class SingleMagnifierPoint extends BaseMagnifierPoint
  @count: 0
  
  selectedRadius: 60
  
  constructor: ->
    super
    SingleMagnifierPoint.count++
  
  destroy: =>
    super
    SingleMagnifierPoint.count--
    
module.exports = SingleMagnifierPoint