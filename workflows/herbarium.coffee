Rectangle = require '../drawing-tools/rectangle'
Pinpoint = require '../drawing-tools/pinpoint'
FreeDraw = require '../drawing-tools/free-draw-tool'
TextTask = require '../tasks/text'
TextareaTask = require '../tasks/textarea'

module.exports =
  key: 'herbarium'
  label: 'Herbarium'
  subjectGroup: 'herbarium'
  firstTask: 'flowering'
  examples: require '../content/examples'
  tutorialSteps: require '../content/tutorial-steps'
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
      confirmButtonLabel: 'Finish'
      defaults: {}
      choices: [{
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
        length: 3
      }]
      next: null
    flowering:
      type: 'radio'
      question: 'Identify the flowering stage of this specimen.'
      next: 'marking'
      choices: [{
        label: 'in bud'
        value: 'bud'
      },{
        label: '½ spike in flower'
        value: 'half'
      },{
        label: 'full spike in flower'
        value: 'full'
      },{
        label: 'spike tip only in flower'
        value: 'tip'
      },{
        label: 'flowering over/in fruit/seed'
        value: 'over'
      }]