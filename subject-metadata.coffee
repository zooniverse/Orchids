Controller = require 'zooniverse/controllers/base-controller'
Api = require 'zooniverse/lib/api'

class SubjectMetadata extends Controller
  
  template: (context) ->
    "
      <p class='subject-metadata'><b>Specimen:</b> #{context.metadata?.specimen_number}</p>
    "
  
  metadata:
    volume: ''
    year: ''
    page_no: ''
  
  constructor: ->
    super
    
    classify_page = null
    @listenTo Api, 'ready', (e) =>
      currentProject = require 'zooniverse-readymade/current-project'
      classify_page = currentProject.classifyPages[0]
    
      @listenTo classify_page.Subject, 'select', (e, subject) =>
        @metadata = subject.metadata
        @el.html @template @
  
  listenTo: (thing, eventName, handler) ->
    addEvent = if 'on' of thing then 'on' else 'addEventListener'
    removeEvent = if 'off' of thing then 'off' else 'removeEventListener'

    thing[addEvent] eventName, handler

    @on 'destroy', ->
      thing[removeEvent] eventName, handler

module.exports = SubjectMetadata