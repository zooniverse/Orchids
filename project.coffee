UploadForm = require './upload'
upload_form = new UploadForm

module.exports =
  id: 'orchids'
  background: 'background.jpg'
  subjectGroup: false

  title: 'Orchid Observers'
  summary: 'hello world'
  description: '''
    short project description goes here.
                 '''
  

  pages: [{
      'Upload': [{
        'Form': upload_form
      },{
        'Resources': 'Links to resources for observers.'
      }]
    },{
    'Science': [
      {
        'Orchid Observers': 'About the project.'
      },{
        'The Team': 'About the people.'
      }]
  }]
  
  externalLinks:
    Talk: ''
    Blog: ''
  
  workflows: [
    require './workflows/herbarium'
    require './workflows/field'
  ]

