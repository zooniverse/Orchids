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
  
  workflows: [{
    key: 'herbarium'
    label: 'Herbarium'
    firstTask: 'marking'
    examples: require './content/examples'
    tutorialSteps: require './content/tutorial-steps'
    tasks:
      marking:
        type: 'drawing'
        question: 'Draw a rectangle around the label for this specimen'
        choices: [{
          type: Rectangle
          label: 'Specimen label'
          value: 'rectangle'
          color: '#006666'
          checked: true
        }]
        next: 'verify'
      verify:
        type: 'text'
        question: 'Verify the specimen label'
        choices: [{
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
          length: 3
        }]
        next: 'flowering'
      flowering:
        type: 'radio'
        question: 'Identify the flowering stage of this specimen.'
        confirmButtonLabel: 'Finish'
        choices: [{
          label: 'one'
          value: 'one'
        },{
          label: 'two'
          value: 'two'
        },{
          label: 'three'
          value: 'three'
        }]
  },{
    key: 'field'
    label: 'Field photos'
    examples: require './content/examples'
    tutorialSteps: require './content/tutorial-steps'
    tasks: {}
  }]

