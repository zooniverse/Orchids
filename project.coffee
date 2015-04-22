UploadForm = require './upload'
upload_form = new UploadForm
team_page = require './templates/team-page'
team = require './content/team'

module.exports =
  id: 'orchid'
  background: 'background.jpg'
  subjectGroup: false

  title: 'Orchid Observers'
  summary: 'Is climate change affecting the UK’s orchids?'
  description: '''
    Photograph wild orchids this summer and annotate museum specimens to contribute to climate change research at the Natural History Museum. Gathering new photographs of UK orchids and extracting data on flowering times from over 10,000 Museum specimens is a huge task, so we need your help. Get involved here!
                 '''

  pages: [{
      'Upload': [{
        'Form': upload_form
      },{
        'Resources': require './content/resources'
      }]
    },{
    'Science': [
      {
        'The Science': require './content/science'
      },{
        'The Team': team_page team
      }]
  }]
  
  externalLinks:
    Talk: '//talk.orchidobservers.org'
    Blog: '//blog.orchidobservers.org'
  
  workflows: [
    require './workflows/herbarium'
    require './workflows/field'
  ]

