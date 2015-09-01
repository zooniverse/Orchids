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
      key: 'upload'
      title: 'Upload'
      content: [{
        key: 'upload-photos'
        title: 'Upload photos'
        content: upload_form
      },{
        key: 'resources'
        title: 'Resources'
        content: require './content/resources'
      }]
    },{
    key: 'science'
    title: 'Science'
    content: [
      {
        key: 'the-science'
        title: 'The Science'
        content: require './content/science'
      },{
        key: 'the-team'
        title: 'The Team'
        content: team_page team
      }]
  }]
  
  externalLinks:
    Talk: '//talk.orchidobservers.org'
    Blog: '//blog.orchidobservers.org'
  
  workflows: [
    require './workflows/herbarium'
    require './workflows/field'
  ]

