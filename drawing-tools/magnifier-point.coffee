MagnifierPoint = require 'marking-surface/lib/tools/magnifier-point'

class SingleMagnifierPoint extends MagnifierPoint
  @count = 0
  
  constructor: ->
    super
    SingleMagnifierPoint.count++
  
  destroy: =>
    super
    SingleMagnifierPoint.count--
    
module.exports = SingleMagnifierPoint