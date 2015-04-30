Controller = require 'zooniverse/controllers/base-controller'
Api = require 'zooniverse/lib/api'
groups = require './workflows/groups'

class ViceCounty extends Controller
  className: 'subject-metadata'
  
  template: (context) ->
    "
      <p>
        <b>Vice County:</b> #{context.metadata?.vice_county}
      </p>
    "
  
  metadata:
    vice_county: ''
  
  constructor: ->
    super
    
    classify_page = null
    @listenTo Api, 'ready', (e) =>
      currentProject = require 'zooniverse-readymade/current-project'
      classify_page = currentProject.classifyPages[1]
    
      @listenTo classify_page.Subject, 'select', (e, subject) =>
        @metadata = subject.metadata
        
        @el.html @template @
  
  listenTo: (thing, eventName, handler) ->
    addEvent = if 'on' of thing then 'on' else 'addEventListener'
    removeEvent = if 'off' of thing then 'off' else 'removeEventListener'

    thing[addEvent] eventName, handler

    @on 'destroy', ->
      thing[removeEvent] eventName, handler

module.exports = ViceCounty