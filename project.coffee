Rectangle = require './drawing-tools/rectangle'
Pinpoint = require './drawing-tools/pinpoint'

module.exports =
  id: 'orchids'
  background: 'background.jpg'
  subjectGroup: false

  title: '<img src="logo.png" alt="Orchid Observers" width=200>'
  summary: 'hello world'
  description: '''
                 '''
  

  pages: []
  
  externalLinks: {}

  tasks:
    marking:
      type: 'drawing'
      question: 'Example marking task'
      choices: [{
        type: Rectangle
        label: 'one'
        value: 'one'
        color: '#006666'
        checked: true
      },{
        type: Rectangle
        label: 'two'
        value: 'two'
        color: '#666666'
      }]

  firstTask: 'marking'
  
  examples: []

  tutorialSteps: []

