Controller = require 'zooniverse/controllers/base-controller'
Api = require 'zooniverse/lib/api'
User = require 'zooniverse/models/user'

class UploadForm extends Controller
  
  template: (context) -> "
    <h2>Upload</h2>
    <p>This will be the upload form.</p>
    <p>Current user: #{User.current?.name}</p>
  "
  
  constructor: ->
    super
    
    @listenTo User, 'change', (e, user) =>
      @el.html @template @
        
  
  listenTo: (thing, eventName, handler) ->
    addEvent = if 'on' of thing then 'on' else 'addEventListener'
    removeEvent = if 'off' of thing then 'off' else 'removeEventListener'

    thing[addEvent] eventName, handler

    @on 'destroy', ->
      thing[removeEvent] eventName, handler

module.exports = UploadForm