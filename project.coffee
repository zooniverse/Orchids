Rectangle = require './drawing-tools/rectangle'
Pinpoint = require './drawing-tools/pinpoint'
FreeDraw = require './drawing-tools/free-draw-tool'
TextTask = require './tasks/text'

module.exports =
  id: 'orchids'
  background: 'background.jpg'
  subjectGroup: false

  title: '<img src="logo.png" alt="Orchid Observers" width=200>'
  summary: 'hello world'
  description: '''
                 '''
  

  pages: [{
      'Upload': 'This will be the iRecord form.'
    },{
    'About': [
      {
        'Orchid Observers': 'About the project.'
      },{
        'The Team': 'About the people.'
      }]
  }]
  
  externalLinks: {}

  tasks:
    verify:
      type: 'text'
      question: 'Verify the specimen label'
      choices: [{
        label: 'Specimen ID'
        key: 'specimen_id'
        value: ''
        disabled: true
      },{
        label: 'Species'
        key: 'species'
        value: ''
      },{
        label: 'Date'
        key: 'date'
        value: ''
      },{
        label: 'Locality'
        key: 'locality'
        value: ''
      },{
        label: 'Vice-county'
        key: 'vc'
        value: ''
        type: 'number'
      }]
    marking:
      type: 'drawing'
      question: 'Example marking task'
      choices: [{
        type: Rectangle
        label: 'rectangle'
        value: 'rectangle'
        color: '#006666'
        checked: true
      },{
        type: Pinpoint
        label: 'point'
        value: 'point'
        color: '#666666'
      },{
        type: FreeDraw
        label: 'line'
        value: 'line'
        color: 'yellow'
      }]

  firstTask: 'verify'
  
  examples: require './content/examples'

  tutorialSteps: require './content/tutorial-steps'

