Rectangle = require '../drawing-tools/rectangle'
Pinpoint = require '../drawing-tools/pinpoint'
FreeDraw = require '../drawing-tools/free-draw-tool'
TextTask = require '../tasks/text'
TextareaTask = require '../tasks/textarea'
OrchidFilterTask = require '../tasks/filter'
MagnifierPoint = require '../drawing-tools/magnifier-point'

module.exports =
  key: 'field'
  subjectGroup: 'field'
  label: 'Field photos'
  firstTask: 'species'
  examples: require '../content/examples'
  tutorialSteps: require '../content/tutorial-steps'
  tasks: 
    species:
      type: OrchidFilterTask.type
      question: 'Pick a photo to identify the type of orchid'
      filters: [
        require './filter-colours'
        require './filter-habitats'
      ]
      choices: require './orchid-types'
      next: 'marking'
    marking:
      type: 'drawing'
      question: 'Help us by labelling the flowering stage of each flower. Identify any insects in the photo by clicking on them.'
      confirmButtonLabel: 'Finish'
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
          type: 'textarea'
          key: 'insects'
          choices:[{
            value: ''
            key: 'comments'
            label: 'What insects can you see?'
          }]
        }]
      }]