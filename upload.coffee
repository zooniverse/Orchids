Controller = require 'zooniverse/controllers/base-controller'
Api = require 'zooniverse/lib/api'
User = require 'zooniverse/models/user'

class UploadForm extends Controller
  
  className: 'readymade-generic-page'
  
  template: (context) ->
    logged_in = """
        <h2>Upload photos</h2>
        <p>Upload photos of UK orchids that you have found during the 2015 field season here. See the <a href="#/upload/resources">resources section</a> to view field recording instructions and find out more about the 29 orchid species that we are asking you to find. You can also learn why we are asking you to tell us your name and sign-in to Zooniverse, along with how your images and observation data will be managed.</p>
        <iframe name=upload title="Upload photos to the Biodiversity Research Centre" seamless src='http://www.brc.ac.uk/iframe-host/zooniverse/enter-orchid-record?external=t&email=#{User.current?.email}&username=#{User.current?.name}'></iframe>
      """
    logged_out = """
      <h2>Upload photos</h2>
      <p>Upload photos of UK orchids that you have found during the 2015 field season here. See the <a href="#/upload/resources">resources section</a> to view field recording instructions and find out more about the 29 orchid species that we are asking you to find. You can also learn why we are asking you to tell us your name and sign-in to Zooniverse, along with how your images and observation data will be managed.</p>
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