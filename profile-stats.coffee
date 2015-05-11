Controller = require 'zooniverse/controllers/base-controller'
User = require 'zooniverse/models/user'
group_ids = require './workflows/groups'

class ProfileStats extends Controller
  
  template: (context) -> 
    return '' unless context.user
    "
      <h2>Your classifications</h2>
      <ul>
        #{(for key, message of context.messages
          "<li>#{message}</li>"
        ).join '\n'}
      </ul>
    "
  
  messages: {}
  
  user: null
  
  constructor: ->
    super
    
    @listenTo User, 'change', (e, @user) =>
      @setGroupMessages()
      @el.html @template @
  
  setGroupMessages: ->
    return unless @user
    for key, group of @user.project.groups
      switch key
        when group_ids.batch1
          @messages[key] = "Checked <span class='count'>#{group.classification_count}</span> herbarium records."
        when group_ids.batch2
          @messages[key] = "Transcribed <span class='count'>#{group.classification_count}</span> herbarium records."
        when group_ids.field
          @messages[key] = "Identified <span class='count'>#{group.classification_count}</span> field photos."
        
  
  listenTo: (thing, eventName, handler) ->
    addEvent = if 'on' of thing then 'on' else 'addEventListener'
    removeEvent = if 'off' of thing then 'off' else 'removeEventListener'

    thing[addEvent] eventName, handler

    @on 'destroy', ->
      thing[removeEvent] eventName, handler

module.exports = ProfileStats