Rectangle = require '../drawing-tools/rectangle'
Pinpoint = require '../drawing-tools/pinpoint'
FreeDraw = require '../drawing-tools/free-draw-tool'
TextTask = require '../tasks/text'
TextareaTask = require '../tasks/textarea'

module.exports =
  key: 'field'
  subjectGroup: 'field'
  label: 'Field photos'
  firstTask: 'marking'
  examples: require '../content/examples'
  tutorialSteps: require '../content/tutorial-steps'
  tasks: 
    species:
      type: 'text'
      question: 'Verify the species'
      confirmButtonLabel: 'Finish'
      defaults: {}
      choices: [{
        label: 'Species'
        key: 'species'
        value: ''
      }]
    marking:
      type: 'drawing'
      question: 'Help us by labelling the flowering stage of each flower. Identify any insects in the photo by clicking on them.'
      next: 'species'
      choices: [{
          type: Pinpoint
          label: 'Flowering stage'
          value: 'flowering'
          checked: true
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
        },{
        type: Pinpoint
        label: 'Insects'
        value: 'insects'
        details: [{
          type: 'text'
          key: 'insects'
          choices:[{
            value: ''
            key: 'common'
            label: 'Common name'
          },{
            value: ''
            key: 'scientific'
            label: 'Scientific name (if known)'
          }]
        }]
      }]