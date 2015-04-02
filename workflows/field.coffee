Rectangle = require '../drawing-tools/rectangle'
Pinpoint = require '../drawing-tools/pinpoint'
FreeDraw = require '../drawing-tools/free-draw-tool'
TextTask = require '../tasks/text'
TextareaTask = require '../tasks/textarea'
OrchidFilterTask = require '../tasks/filter'
MagnifierPoint = require 'marking-surface/lib/tools/magnifier-point'

module.exports =
  key: 'field'
  subjectGroup: 'field'
  label: 'Field photos'
  firstTask: 'marking'
  examples: require '../content/examples'
  tutorialSteps: require '../content/tutorial-steps'
  tasks: 
    species:
      type: OrchidFilterTask.type
      question: 'Verify the species'
      confirmButtonLabel: 'Finish'
      filters: [
        require './filter-colours'
        require './filter-habitats'
      ]
      choices: require './orchid-types'
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
        type: MagnifierPoint
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