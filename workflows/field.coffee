Rectangle = require '../drawing-tools/rectangle'
Pinpoint = require '../drawing-tools/pinpoint'
FreeDraw = require '../drawing-tools/free-draw-tool'
TextTask = require '../tasks/text'
TextareaTask = require '../tasks/textarea'

module.exports =
  key: 'field'
  subjectGroup: 'field'
  label: 'Field photos'
  firstTask: 'flowering'
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
      next: 'flowering'
    flowering:
      type: 'radio'
      question: 'Identify the flowering stage of this specimen.'
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
      next: 'pollinators'
    pollinators:
      type: 'drawing'
      question: 'Help us identify any insects near the flower by clicking on them.'
      next: 'species'
      choices: [{
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