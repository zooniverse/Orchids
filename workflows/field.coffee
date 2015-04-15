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
  label: 'Identify'
  firstTask: 'species'
  examples: require '../content/field-examples'
  tutorialSteps: require '../content/field-tutorial'
  tasks: 
    species:
      type: OrchidFilterTask.type
      question: 'Select from the key below to identify the orchid.'
      filters: [
        require './filter-colours'
        require './filter-habitats'
      ]
      choices: require './orchid-types'
      next: 'marking'
    marking:
      type: 'drawing'
      question: 'Click on each orchid and select the flowering stage. If there are any insects on the orchid(s), click on them and tell us what they are.'
      confirmButtonLabel: 'Finish'
      choices: [{
          type: Pinpoint
          label: 'Label flowering stage'
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
              label: 'flowering over/seed capsules'
              value: 'over'
            }]
          }]
        },{
        type: MagnifierPoint
        label: 'Select insects'
        value: 'insects'
        details: [{
          type: 'textarea'
          key: 'insects'
          choices:[{
            value: ''
            key: 'comments'
            label: 'What is the name of this insect? Give as much detail as you can.'
          }]
        }]
      }]