Controller = require 'zooniverse/controllers/base-controller'
Api = require 'zooniverse/lib/api'

class OrchidType extends Controller
  className: 'orchid-type'
  
  template: (context) ->
    "
      <p>#{context.orchid?.label}<br>(<span class='scientific-name'>#{context.orchid?.scientific}</span>)</p>
      <img height=200 src='#{context.orchid?.image.replace '/thumb', '/detail'}' alt='#{context.orchid?.label}: flower detail'>
      <img width=200 src='#{context.orchid?.image.replace '/thumb', '/full'}' alt='#{context.orchid?.label}: full plant'>
    "
  
  orchid:
    image: ''
    label: ''
    scientific: ''
  
  constructor: ->
    super
    
    @el.attr 'aria-hidden', true
    
    classify_page = null
    @listenTo Api, 'ready', (e) =>
      currentProject = require 'zooniverse-readymade/current-project'
      field_page = currentProject.classifyPages[1]
    
      @listenTo field_page.el, field_page.decisionTree.CHANGE, ({originalEvent: {detail}}) =>
        {key, value} = detail
        
        @el.attr 'aria-hidden', true
  
        if key is 'species'
          @orchid = field_page.decisionTree.currentTask.getChoice()
          if @orchid
            @el.html @template @
            @el.attr 'aria-hidden', false
  
  listenTo: (thing, eventName, handler) ->
    addEvent = if 'on' of thing then 'on' else 'addEventListener'
    removeEvent = if 'off' of thing then 'off' else 'removeEventListener'

    thing[addEvent] eventName, handler

    @on 'destroy', ->
      thing[removeEvent] eventName, handler

module.exports = OrchidType