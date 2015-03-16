Rectangle = require './drawing-tools/rectangle'
Pinpoint = require './drawing-tools/pinpoint'
FreeDraw = require './drawing-tools/free-draw-tool'

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

  firstTask: 'marking'
  
  examples: require './content/examples'

  tutorialSteps: require './content/tutorial-steps'

