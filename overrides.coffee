MAX_PAGE_WIDTH = 600

require './readymade/overrides.coffee'
SubjectViewer = require 'zooniverse-readymade/lib/subject-viewer'

SubjectViewer::template = require './templates/subject-viewer'

SubjectViewer::rescale = ()->
  width = Math.min MAX_PAGE_WIDTH, @markingSurface.el.parentNode.offsetWidth
  scale = width / @maxWidth
  @markingSurface.maxWidth = @maxWidth
  @markingSurface.maxHeight = @maxHeight
  @zoom scale

SubjectViewer::crop = (rectangle, margin = 25, limit = 1.5)->
  w = rectangle.width + margin * 2
  h = rectangle.height + margin * 2
  scale = @markingSurface.el.parentNode.offsetWidth / w
  scale = Math.min scale, limit
  @markingSurface.svg.attr 'width', scale * w
  @markingSurface.svg.attr 'height', scale * h
  @markingSurface.rescale rectangle.left - margin, rectangle.top - margin, w, h

SubjectViewer::zoom = (scale = 1) ->
  @scale = Math.min scale, 1
  @scale = Math.max @scale, .2
  @markingSurface.svg.attr
    width: @scale * @maxWidth
    height: @scale * @maxHeight
  @markingSurface.rescale()

currentProject = require 'zooniverse-readymade/current-project'
classify_page = currentProject.classifyPages[0]

{decisionTree, subjectViewer} = classify_page
  
ms = subjectViewer.markingSurface

# set the image scale if not already set  
ms.on 'marking-surface:add-tool', (tool) ->
  @rescale() if @scaleX is 0
  
classify_page.on classify_page.LOAD_SUBJECT, (e, subject)->
  ms.rescale 0, 0, subjectViewer.maxWidth, subjectViewer.maxHeight

classify_page.el.on decisionTree.LOAD_TASK, ({originalEvent: detail: {task}})->
  {metadata} = subjectViewer.subject
  task.reset if task.key is 'verify'
    specimen_id: metadata.specimen_id
    species: metadata.species
    date: metadata.date
    locality: metadata.locality

zoom_timeout = null

onZoomIn = (e)->
  e.preventDefault()
  onZoom e.currentTarget, .1
  
onZoomOut = (e)->
  e.preventDefault()
  onZoom e.currentTarget, -.1
  
onKeyZoomIn = (e)->
  return unless e.which == 13
  onZoom e.currentTarget, .1

onKeyZoomOut = (e)->
  return unless e.which == 13
  onZoom e.currentTarget, -.1

onStopZoom = (e)->
  e.stopPropagation()
  onZoom e.currentTarget, 0
  
onZoom = (currentTarget, delta)->
  clearTimeout zoom_timeout if zoom_timeout?

  zoom = ->
    return if delta == 0
    subjectViewer.zoom subjectViewer.scale + delta
    clearTimeout zoom_timeout if zoom_timeout?
    zoom_timeout = setTimeout zoom, 200
    
  zoom()

zoom_in = document.getElementById 'zoom-in'
zoom_out = document.getElementById 'zoom-out'

zoom_in.addEventListener 'mousedown', onZoomIn
zoom_in.addEventListener 'mouseup', onStopZoom
zoom_out.addEventListener 'mousedown', onZoomOut
zoom_out.addEventListener 'mouseup', onStopZoom
zoom_in.addEventListener 'touchstart', onZoomIn
zoom_in.addEventListener 'touchend', onStopZoom
zoom_out.addEventListener 'touchstart', onZoomOut
zoom_out.addEventListener 'touchend', onStopZoom
zoom_in.addEventListener 'keydown', onKeyZoomIn
zoom_in.addEventListener 'keyup', onStopZoom
zoom_out.addEventListener 'keydown', onKeyZoomOut
zoom_out.addEventListener 'keyup', onStopZoom

