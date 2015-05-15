MAX_PAGE_WIDTH = 600

require './readymade/overrides.coffee'
window.zooniverse ?= {}
window.zooniverse.views ?= {}
window.zooniverse.views.profile = require './templates/profile'

Dialog = require 'zooniverse/controllers/dialog'
User = require 'zooniverse/models/user'
SubjectMetadata = require './subject-metadata'
ViceCounty = require './vice-county'
OrchidType = require './orchid-type'
SubjectViewer = require 'zooniverse-readymade/lib/subject-viewer'
ClassifyPage = require 'zooniverse-readymade/lib/classify-page'
SiteHeader = require 'zooniverse-readymade/lib/site-header'
ProfileStats = require './profile-stats'

OrchidFilterTask = require './tasks/filter'
DecisionTree = require 'zooniverse-decision-tree'
  
ClassifyPage::showPageHelp = () ->
  @fieldGuideContainer.attr 'aria-hidden', !@help.checked
  @fieldGuide.goTo @subjectViewer.taskIndex

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

currentProject.homePage.querySelector( '.readymade-footer' ).insertAdjacentHTML 'beforeEnd', '<a href="#/upload" class="readymade-call-to-action">Upload photos</a>'
  
profile_stats = new ProfileStats
currentProject.profile.el.find('.profile-stats').append profile_stats.el

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
      
      if page.decisionTree.currentTask.key is 'barcode'
        task = page.decisionTree.currentTask
        task.check task.choices[1]
        
    ms.on 'marking-surface:remove-tool', (tool) ->
      if page.decisionTree.currentTask.key is 'barcode'
        task = page.decisionTree.currentTask
        choice = (choice for choice in task.choices when choice.value == tool.mark.value)[0]
        task.check choice
    
    page.on page.LOAD_SUBJECT, (e, subject)->
      ms.rescale 0, 0, subjectViewer.maxWidth, subjectViewer.maxHeight
    
    page.el.on decisionTree.LOAD_TASK, ({originalEvent: detail: {task}})->
      if task.key is 'verify'
        rectangle = tool.mark for tool in ms.tools when tool.mark.value is 'specimen-label'
        subjectViewer.crop rectangle
      else
        image = ms.root.el.querySelectorAll('g.frames image')[subjectViewer.currentFrame]
        subjectViewer.maxWidth = parseInt image.getAttribute 'width'
        subjectViewer.maxHeight = parseInt image.getAttribute 'height'
        subjectViewer.rescale()
        ms.rescale 0, 0, subjectViewer.maxWidth, subjectViewer.maxHeight
    
    page.Subject.on 'select', (e, subject)->
      {metadata} = subject
      
      if page.workflow is 'herbarium'
        scientific_name = metadata.scientific_name ? ''
        page.decisionTree.tasks.verify.setDefaults
          species: scientific_name
          date: metadata.collection_date_from ? ''
          locality: metadata.locality_string ? ''
          comments: metadata.label_comments ? ''
        
        page.decisionTree.tasks.vc.setDefaults
          vc: metadata.vc_number ? ''
          registration: metadata.registration ? ''
          
        # disable the herbarium species if NHM already know it.
        herbarium_species.disabled = !!scientific_name.length
      
      if page.workflow is 'field'
        page.decisionTree.tasks.species.clearFilters()
        page.decisionTree.tasks.species.confirmButton.disabled = true
    
    page.on page.FINISH_SUBJECT,  (e, page) ->
      group_id = page.subjectViewer.subject.group_id
      if User.current?.project.groups[group_id]
        User.current?.project.groups[group_id].classification_count++
      else
        User.current?.project.groups[group_id] = {title: '', classification_count: 1}
      profile_stats.el.html ''
      profile_stats.setGroupMessages()
      profile_stats.renderTemplate()

# disable the species confirm until a value is chosen.
field_page.el.on field_page.decisionTree.CHANGE, ({originalEvent: {detail}}) ->
  {key, value} = detail
  
  if key is 'species'
    field_page.decisionTree.tasks.species.confirmButton.disabled = false if value

    label = field_page.decisionTree.currentTask.confirmButtonLabel
    label = 'Finish' unless field_page.decisionTree.currentTask.getNext()

    field_page.decisionTree.currentTask.confirmButton.innerHTML = label if label?

# pick a random photo if more than one is present on a field subject
field_page.on field_page.CREATE_CLASSIFICATION, () ->
  subject = field_page.classification.subject
  return unless Array.isArray subject.location.standard
  randomIndex = Math.floor Math.random() * subject.location.standard.length

  field_page.classification.set 'image_index', randomIndex
  field_page.classification.set 'image_src', subject.location.standard[randomIndex]
    
  subject.location.standard = subject.location.standard[randomIndex]

# switch between batch 1 and batch 2 for transcription. Always start on batch 1.
groups = require './workflows/groups'
# start with 10 subjects from batch 1
herbarium_page.Subject.queueMax = 10
herbarium_page.Subject.group = groups.batch1
# the alternate between batch 1 and batch 2
herbarium_page.Subject.on 'fetch', (e, subjects) ->
  if herbarium_page.Subject.group == groups.batch1 
    herbarium_page.Subject.group = groups.batch2 
  else 
    herbarium_page.Subject.group = groups.batch1

# Alert before you do your first full transcription record
herbarium_page.on herbarium_page.LOAD_SUBJECT, (e, subject) ->
  is_transcriber = User.current?.preferences?[currentProject.id]?.transcriber || herbarium_page.transcriber
  transcribeAlert() if subject.group_id == groups.batch2 unless is_transcriber

transcribeAlert = ->
  prompt = new Dialog
    warning: true

    content: """
      <header>You are ready to do some transcribing!</header>
      <p>Now that you've checked #{herbarium_page.Subject.queueMax} Herbarium sheets, you'll start to see some sheets which are marked <strong>Status:</strong> needs transcribing.</p>
      <p>Please copy the species, date and any locality information from the label for these sheets. Add the Vice County number if one is present.</p>
      <p class="action">
        <button name="close-dialog">OK</button>
      </p>
    """

  prompt.show()
  User.current?.setPreference 'transcriber', true
  herbarium_page.transcriber = true
  setTimeout ->
    prompt.el[0].querySelector('button').focus()
      
# add a box to show herbarium barcode number etc.
subject_metadata = new SubjectMetadata
herbarium_page.el.find('.decision-tree').prepend subject_metadata.el

# add a viewer to show the orchid type examples for field photos
orchid_type = new OrchidType
field_page.el.find('.decision-tree').before orchid_type.el

# display the vice county and location for field photos
vice_county = new ViceCounty
field_page.el.find('.decision-tree').prepend vice_county.el

# Custome 'no more subjects' message for uploaded photos
waiting_message = '''
                    <p class="caption"><img src="rosette.jpg" alt="Common spotted-orchid – rosette"><br>Common spotted-orchid rosette, Natural History Museum grounds, 16 April 2015</p>
                   <p>We're waiting for the first photos from the 2015 UK orchid flowering season to appear!</p>
                   <p>Meanwhile, you can help us by <a href="#/upload">uploading your photos</a> or <a href="#/transcribe">transcribing our herbarium sheets</a>.</p>
                   '''
no_field_message = '''
                    <p class="caption"><img src="rosette.jpg" alt="Common spotted-orchid – rosette"><br>Common spotted-orchid rosette, Natural History Museum grounds, 16 April 2015</p>
                   <p>Looks like you've identified all of the available photos. New photos will be uploaded in a few days, while the 2015 flowering season continues.</p>
                   <p>Meanwhile, you can help us by <a href="#/upload">uploading your photos</a> or <a href="#/transcribe">transcribing our herbarium sheets</a>.</p>
                   '''
field_page.noMoreSubjectsMessage.html no_field_message

#  hack: don't show the tutorial unless there's a classification subject
# also, don't call tutorial.close() because that sets the tutorial_done flag.
field_page.on field_page.START_TUTORIAL, (args...) ->
  setTimeout ->
    return if field_page.subjectViewer.subject
    field_page.tutorial.el.setAttribute 'aria-hidden', true
    field_page.tutorial.current_focus?.focus()
  , 250
    
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


