Controller = require 'zooniverse/controllers/base-controller'
Api = require 'zooniverse/lib/api'
User = require 'zooniverse/models/user'

class UploadForm extends Controller
  
  template: (context) ->
    logged_in = """
        <h2>Upload</h2>
        <iframe name=upload title="Upload photos to the Biodiversity Research Centre" seamless src='http://www.brc.ac.uk/iframe-host/zooniverse/enter-orchid-record?external=t&email=#{User.current?.email}&username=#{User.current?.name}'></iframe>
      """
    logged_out = """
      <h2>Upload</h2>
      <p>Please log in to upload photos.</p>
      """
    template = if User.current then logged_in else logged_out
      
  
  constructor: ->
    super
    @el.attr id: 'form'
    
    @listenTo User, 'change', (e, user) =>
      @el.html @template @
      
      iframe = @el.find 'iframe[name=upload]'
      iframe[0]?.style.minHeight = window.innerHeight + 'px'
        
  
  listenTo: (thing, eventName, handler) ->
    addEvent = if 'on' of thing then 'on' else 'addEventListener'
    removeEvent = if 'off' of thing then 'off' else 'removeEventListener'

    thing[addEvent] eventName, handler

    @on 'destroy', ->
      thing[removeEvent] eventName, handler

module.exports = UploadForm