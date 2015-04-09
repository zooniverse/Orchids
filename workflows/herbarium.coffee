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
  examples: require '../content/herbarium-examples'
  tutorialSteps: require '../content/herbarium-tutorial'
  tasks:
    barcode:
      type: 'drawing'
      question: 'Please select the barcode that matches the specimen number above and draw a rectangle around the handwritten label for this barcode.'
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
      question: 'Do the date and locality match the writing on the label? If not, then please enter the correct information.'
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
      }]
      next: 'vc'
    vc:
      type: 'text'
      question: 'If there is a Vice County (VC) number marked in pencil on the sheet, please check that it has been entered correctly.'
      defaults: {}
      choices: [{
        label: 'Vice County number (between 1 and 112)'
        key: 'vc'
        value: ''
        length: 3
      }]
      next: 'flowering'
    flowering:
      type: 'drawing'
      question: 'Finally, please select one of the specimens and estimate its flowering stage. If there is more than one barcode on the sheet, select a specimen close to the barcode that you marked.'
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