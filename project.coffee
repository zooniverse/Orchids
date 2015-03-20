module.exports =
  id: 'orchids'
  background: 'background.jpg'
  subjectGroup: false

  title: 'Orchid Observers'
  summary: 'hello world'
  description: '''
                 '''
  

  pages: [{
      'Upload': 'This will be the iRecord form.'
    },{
      'Resources': 'Links to resources for observers.'
    },{
      'Science': 'The science behind the project'
    },{
    'About': [
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

