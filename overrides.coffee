MAX_PAGE_WIDTH = 600

require './readymade/overrides.coffee'
SubjectMetadata = require './subject-metadata'
OrchidType = require './orchid-type'
SubjectViewer = require 'zooniverse-readymade/lib/subject-viewer'
ClassifyPage = require 'zooniverse-readymade/lib/classify-page'
SiteHeader = require 'zooniverse-readymade/lib/site-header'

OrchidFilterTask = require './tasks/filter'
DecisionTree = require 'zooniverse-decision-tree'
  
ClassifyPage::showPageHelp = () ->
  @fieldGuideContainer.attr 'aria-hidden', !@help.checked

SubjectViewer::template = require './templates/subject-viewer'
SiteHeader::template = require './templates/site-header'

SubjectViewer::rescale = ()->
  width = Math.min MAX_PAGE_WIDTH, .5 * window.innerWidth
  scale = width / @maxWidth
  @zoom scale

SubjectViewer::crop = (rectangle, margin = 25, limit = 1.5)->
  w = rectangle.width + margin * 2
  h = rectangle.height + margin * 2
  scale = @markingSurface.el.parentNode.offsetWidth / w
  scale = Math.min scale, limit
  @markingSurface.svg.attr 'width', parseInt scale * w
  @markingSurface.svg.attr 'height', parseInt scale * h
  @markingSurface.rescale rectangle.left - margin, rectangle.top - margin, w, h
  @maxWidth = w
  @maxHeight = h
  @zoom @markingSurface.scaleX

SubjectViewer::zoom = (scale = 1) ->
  @scale = Math.min scale, 1.0
  @scale = Math.max @scale, .4
  width = Math.min @scale * @maxWidth, @markingSurface.el.parentNode.offsetWidth
  @scale = width / @maxWidth
  @markingSurface.svg.attr
    width: parseInt width
    height: parseInt @scale * @maxHeight
  @markingSurface.rescale()

currentProject = require 'zooniverse-readymade/current-project'
herbarium_page = currentProject.classifyPages[0]
field_page = currentProject.classifyPages[1]
  
herbarium_species = herbarium_page.decisionTree.el.querySelector('input[name=species]')

for page in currentProject.classifyPages
  do (page) ->
    {decisionTree, subjectViewer} = page
    ms = subjectViewer.markingSurface
    
    page.Subject.trackSeenSubject = (subject) ->

    # set the image scale if not already set  
    ms.on 'marking-surface:add-tool', (tool) ->
      @rescale() if @scaleX is 0
      if tool.constructor.count > 1
        tool.deselect()
        tool.destroy()
        @selection = null
    
      {label} = decisionTree.currentTask.getChoice() ? ''
      legend = tool.controls?.el.querySelector 'legend'
      legend.textContent = label if legend?
    
    page.on page.LOAD_SUBJECT, (e, subject)->
      ms.rescale 0, 0, subjectViewer.maxWidth, subjectViewer.maxHeight
    
    page.el.on decisionTree.LOAD_TASK, ({originalEvent: detail: {task}})->
      if task.key is 'verify'
        rectangle = tool.mark for tool in ms.tools when tool.mark.value is 'specimen-label'
        subjectViewer.crop rectangle
      else
        image = ms.root.el.querySelector 'g.frames image'
        subjectViewer.maxWidth = parseInt image.getAttribute 'width'
        subjectViewer.maxHeight = parseInt image.getAttribute 'height'
        subjectViewer.rescale()
        ms.rescale 0, 0, subjectViewer.maxWidth, subjectViewer.maxHeight
    
    page.Subject.on 'select', (e, subject)->
      {metadata} = subject
      
      if page.workflow is 'herbarium'
        page.decisionTree.tasks.verify.setDefaults
          species: metadata.scientific_name
          date: metadata.collection_date_from
          locality: metadata.locality_string
          comments: metadata.label_comments
        
        page.decisionTree.tasks.vc.setDefaults
          vc: metadata.vc_number
          registration: metadata.registration
          
        # disable the herbarium species if NHM already know it.
        herbarium_species.disabled = !!metadata.scientific_name.length
      
      if page.workflow is 'field'
        page.decisionTree.tasks.species.clearFilters()
      

subject_metadata = new SubjectMetadata
herbarium_page.el.find('.decision-tree').prepend subject_metadata.el

orchid_type = new OrchidType
field_page.el.find('.decision-tree').before orchid_type.el
    
# herbarium_page.el.on decisionTree.LOAD_TASK, ({originalEvent: detail: {task, index}})->
  
for page in [herbarium_page, field_page]
  page.help = page.el[0].querySelector('input[name=help]')
  page.fieldGuideContainer.attr 'aria-hidden', !page.help.checked
    
  do (page)->
    page.help.addEventListener 'change', (e)->
      page.showPageHelp()
    
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
        page.subjectViewer.zoom page.subjectViewer.scale + delta
        clearTimeout zoom_timeout if zoom_timeout?
        zoom_timeout = setTimeout zoom, 200
    
      zoom()
    
    zoom_in = page.el[0].querySelector '[name=zoom-in]'
    zoom_out = page.el[0].querySelector '[name=zoom-out]'

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


