Rectangle = require '../drawing-tools/rectangle'
Pinpoint = require '../drawing-tools/pinpoint'
FreeDraw = require '../drawing-tools/free-draw-tool'
TextTask = require '../tasks/text'
TextareaTask = require '../tasks/textarea'
OrchidFilterTask = require '../tasks/filter'
MagnifierPoint = require 'marking-surface/lib/tools/magnifier-point'

groups = require './groups'

module.exports =
  key: 'field'
  subjectGroup: groups.field
  label: 'Identify'
  firstTask: 'species'
  examples: require '../content/field-examples'
  tutorialSteps: require '../content/field-tutorial'
  tasks: 
    species:
      type: OrchidFilterTask.type
      question: 'Can you identify the orchid by comparing with plants from the following grid?<br><a href="resources/OrchidObservers_IDGuide_v2.pdf">Identification Guide (16MB PDF)</a>'
      filters: [
        require './filter-colours'
        require './filter-habitats'
      ]
      choices: require './orchid-types'
      next: 'flowering'
    flowering:
      type: 'drawing'
      question: 'Click on each orchid and select the flowering stage.'
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
        }]
      next: 'insects'
    insects:
      type: 'drawing'
      question: 'If there are any insects on the orchid(s), click on them to mark them.'
      confirmButtonLabel: 'Finish'
      choices: [{
        type: MagnifierPoint
        label: 'Select insects'
        value: 'insects'
      }]