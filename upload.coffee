Controller = require 'zooniverse/controllers/base-controller'
Api = require 'zooniverse/lib/api'
User = require 'zooniverse/models/user'

class UploadForm extends Controller
  
  className: 'readymade-generic-page'
  
  template: (context) ->
    logged_in = """
        <h2>Upload photos</h2>
        <p>Upload photos of UK orchids that you have found during the 2015 field season here. See the <a href="#/upload/resources">resources section</a> to view field recording instructions and find out more about the 29 orchid species that we are asking you to find. You can also learn why we are asking you to tell us your name and sign-in to Zooniverse, along with how your images and observation data will be managed.</p>
        <h3>Guides to download</h3>
        <p><a href="resources/OrchidObservers_InstructionSheet.pdf">Instructions for observers (145KB PDF)</a></p>
        <p><a href="resources/OrchidObservers_IDGuide_v2.pdf">UK Orchid Identification Guide (16MB PDF)</a></p>
        <iframe name=upload title="Upload photos to the Biodiversity Research Centre" seamless src='http://www.brc.ac.uk/iframe-host/zooniverse/enter-orchid-record?external=t&email=#{User.current?.email}&username=#{User.current?.name}'></iframe>
      """
    logged_out = """
      <h2>Upload photos</h2>
      <p>Upload photos of UK orchids that you have found during the 2015 field season here. See the <a href="#/upload/resources">resources section</a> to view field recording instructions and find out more about the 29 orchid species that we are asking you to find. You can also learn why we are asking you to tell us your name and sign-in to Zooniverse, along with how your images and observation data will be managed.</p>
      <h3>Guides to download</h3>
      <p><a href="resources/OrchidObservers_InstructionSheet.pdf">Instructions for observers (145KB PDF)</a></p>
      <p><a href="resources/OrchidObservers_IDGuide_v2.pdf">UK Orchid Identification Guide (16MB PDF)</a></p>
      <p>Please log in to upload photos.</p>
      """
    offline = """
      <h2>Upload photos</h2>
      <p>A huge thank you to all our participants who photographed and submitted their images and records of wild orchids throughout 2015. We’ve now collected all the field data for our analysis but if you photograph orchids this year, please submit them direct to the Botanical Society of Britain and Ireland (BSBI) – you can find contact details for the BSBI in your area <a href="http://bsbi.org/local-botany">here</a></p>
      <p>We’d love your help to finish transcribing the labels and classifying flowering stage for our historical orchid collection on the <a href="#transcribe">Transcribe</a> page.</p>
      <p>Thanks for your help!</p>
                  """
    
    # template = if User.current then logged_in else logged_out
    template = offline
      
  
  constructor: ->
    super
    @el.attr id: 'upload-photos'
    
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