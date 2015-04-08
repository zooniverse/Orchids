Rectangle = require '../drawing-tools/rectangle'
Pinpoint = require '../drawing-tools/pinpoint'
FreeDraw = require '../drawing-tools/free-draw-tool'
TextTask = require '../tasks/text'
TextareaTask = require '../tasks/textarea'
SingleMagnifierPoint = require '../drawing-tools/single-magnifier-point'

module.exports =
  key: 'herbarium'
  label: 'Herbarium'
  subjectGroup: '5523e3577b9f994c14000001'
  firstTask: 'barcode'
  examples: require '../content/examples'
  tutorialSteps: require '../content/tutorial-steps'
  tasks:
    barcode:
      type: 'drawing'
      question: 'Find the barcode and handwritten label for this specimen'
      choices: [{
        type: SingleMagnifierPoint
        label: 'Barcode'
        value: 'barcode'
        color: '#660066'
        checked: true
      },{
        type: Rectangle
        label: 'Specimen label'
        value: 'specimen-label'
        color: '#006666'
      }]
      next: 'verify'
    verify:
      type: 'text'
      question: 'Verify the written specimen label'
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
        label: 'Label comments'
        key: 'comments'
        value: ''
      }]
      next: 'vc'
    vc:
      type: 'text'
      question: 'There may be a VC number and registration label also on the sheet.'
      defaults: {}
      choices: [{
        label: 'Vice-county'
        key: 'vc'
        value: ''
        length: 3
      },{
        label: 'Registration'
        key: 'registration'
        value: ''
      }]
      next: 'flowering'
    flowering:
      type: 'drawing'
      question: 'Identify the flowering stage of this specimen.'
      next: 'marking'
      confirmButtonLabel: 'Finish'
      choices: [{
        type: Pinpoint
        label: 'Flowering stage'
        value: 'flowering'
        details: [{
          type: 'radio'
          key: 'flowering'
          choices: [{
            label: 'mainly in bud'
            value: 'bud'
          },{
            label: 'mainly in flower'
            value: 'flower'
          },{
            label: 'flowering over/in fruit/seed'
            value: 'over'
          }]
        }]
      }]