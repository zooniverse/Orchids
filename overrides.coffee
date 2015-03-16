MAX_PAGE_WIDTH = 600

require './readymade/overrides.coffee'
SubjectViewer = require 'zooniverse-readymade/lib/subject-viewer'

SubjectViewer::rescale = ()->
  width = Math.min MAX_PAGE_WIDTH, @markingSurface.el.parentNode.offsetWidth
  scale = width / @maxWidth
  @markingSurface.maxWidth = @maxWidth
  @markingSurface.maxHeight = @maxHeight
  @markingSurface.svg.attr
    width: scale * @maxWidth
    height: scale * @maxHeight

SubjectViewer::crop = (rectangle, margin = 25, limit = 1.5)->
  w = rectangle.width + margin * 2
  h = rectangle.height + margin * 2
  scale = @markingSurface.el.parentNode.offsetWidth / w
  scale = Math.min scale, limit
  @markingSurface.svg.attr 'width', scale * w
  @markingSurface.svg.attr 'height', scale * h
  @markingSurface.rescale rectangle.left - margin, rectangle.top - margin, w, h

currentProject = require 'zooniverse-readymade/current-project'
classify_page = currentProject.classifyPages[0]

{decisionTree, subjectViewer} = classify_page
  
ms = subjectViewer.markingSurface

# set the image scale if not already set  
ms.on 'marking-surface:add-tool', (tool) ->
  @rescale() if @scaleX is 0
  
classify_page.on classify_page.LOAD_SUBJECT, (e, subject)->
  ms.rescale 0, 0, subjectViewer.maxWidth, subjectViewer.maxHeight

