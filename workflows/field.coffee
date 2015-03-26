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
      type: 'filter'
      question: 'Verify the species'
      confirmButtonLabel: 'Finish'
      filters: [{
        label: "Colour"
        key: 'colour'
        values: [{
          value: "white"
          label: "White"
        }, {
          value: "white-purple"
          label: "White & purple"
        }, {
          value: "pale-pink"
          label: "Pale pink"
        },{
          value: "lilac-purple"
          label: "Lilac-purple"
        },{
          value: "pink"
          label: "Pink"
        },{
          value: "reddish-pink"
          label: "Reddish-pink"
        },{
          value: "purplish-pink"
          label: "Purplish-pink"
        },{
          value: "purple"
          label: "Purple"
        },{
          value: "reddish-purple"
          label: "Reddish-purple"
        },{
          value: "yellow-green"
          label: "Yellowish-green"
        },{
          value: "green-red"
          label: "Greenish-reddish"
        },{
          value: "brown"
          label: "Brown"
        },{
          value: "multi"
          label: "Multi-colour"
        }]
      },{
        label: "Habitat"
        key: "habitat"
        values: [{
          value: "deciduous"
          label: "Deciduous woodland"
        },{
          value: "coniforous"
          label: "Coniforous woodland"
        },{
          value: "grassland"
          label: "Grassland"
        },{
          value: "heathland"
          label: "Heathland and moors"
        },{
          value: "marshes"
          label: "Marshes and fens"
        },{
          value: "dunes"
          label: "Dunes and dune slacks"
        },{
          value: "quarries"
          label: "Man-made (quarries, railway lines, old industrial sites etc)"
        },{
          value: "verges"
          label: "Man-made (road verges, churchyards etc)"
        }]
      }]
      choices: [{
        label: 'White Helleborine'
        value: 'white-helleborine'
        traits: 
          colour: ["white"]
          habitat: ["deciduous"]
      },{
        label: 'Creeping Lady\'s Tresses'
        value: 'creeping-ladys-tresses'
        traits: 
          colour: ["white"]
          habitat: ["coniforous"]
      },{
        label: 'Lesser Butterfly Orchid'
        value: 'lesser-butterfly'
        traits: 
          colour: ["white"]
          habitat: ["grassland", "heathland"]
      },{
        label: 'Greater Butterfly Orchid'
        value: 'greater-butterfly'
        traits: 
          colour: ["white"]
          habitat: ["grassland"]
      },{
        label: 'Small-white Orchid'
        value: 'small-white'
        traits: 
          colour: ["white"]
          habitat: ["grassland"]
      },{
        label: 'Autumn Lady\'s Tresses'
        value: 'autumn-ladys-tresses'
        traits: 
          colour: ["white"]
          habitat: ["grassland"]
      },{
        label: 'Marsh Helleborine'
        value: 'marsh-helleborine'
        traits: 
          colour: ["white-purple"]
          habitat: ["marshes"]
      },{
        label: 'Common Spotted-orchid'
        value: 'common-spotted'
        traits: 
          colour: ["pale-pink", "pink", "purplish-pink"]
          habitat: ["deciduous", "grassland", "marshes", "dunes"]
      },{
        label: 'Green-winged Orchid'
        value: 'green-winged'
        traits: 
          colour: ["pale-pink", "pink", "purplish-pink"]
          habitat: ["grassland", "dunes", "verges"]
      },{
        label: 'Pyramidal Orchid'
        value: 'pyramidal'
        traits: 
          colour: ["pale-pink", "pink", "reddish-pink"]
          habitat: ["grassland", "marshes", "verges"]
      },{
        label: 'Heath Spotted-orchid'
        value: 'heath-spotted'
        traits: 
          colour: ["purplish-pink"]
          habitat: ["grassland", "heathland"]
      },{
        label: 'Southern Marsh-orchid'
        value: 'southern-marsh'
        traits: 
          colour: ["purplish-pink"]
          habitat: ["marshes", "quarries"]
      },{
        label: 'Marsh Fragrant-orchid'
        value: 'marsh-fragrant'
        traits: 
          colour: ["purplish-pink"]
          habitat: ["marshes"]
      },{
        label: 'Heath Fragrant-orchid'
        value: 'heath-fragrant'
        traits: 
          colour: ["lilac-purple"]
          habitat: ["grassland", "heathland"]
      },{
        label: 'Chalk Fragrant-orchid'
        value: 'chalk-fragrant'
        traits: 
          colour: ["lilac-purple"]
          habitat: ["grassland"]
      },{
        label: 'Common Fragrant-orchid'
        value: 'common-fragrant'
        traits: 
          colour: ["lilac-purple"]
          habitat: ["quarries", "verges"]
      },{
        label: 'Early Purple Orchid'
        value: 'early-purple'
        traits: 
          colour: ["purple"]
          habitat: ["deciduous", "grassland"]
      },{
        label: 'Burnt Orchid'
        value: 'burnt'
        traits: 
          colour: ["reddish-purple"]
          habitat: ["grassland"]
      },{
        label: 'Northern Marsh-orchid'
        value: 'northern-marsh'
        traits: 
          colour: ["reddish-purple"]
          habitat: ["marshes", "quarries"]
      },{
        label: 'Common Twayblade'
        value: 'common-twayblade'
        traits: 
          colour: ["yellow-green"]
          habitat: ["deciduous", "grassland"]
      },{
        label: 'Frog Orchid'
        value: 'frog'
        traits: 
          colour: ["yellow-green"]
          habitat: ["grassland"]
      },{
        label: 'Man Orchid'
        value: 'man'
        traits: 
          colour: ["yellow-green"]
          habitat: ["grassland"]
      },{
        label: 'Musk Orchid'
        value: 'musk'
        traits: 
          colour: ["yellow-green"]
          habitat: ["grassland"]
      },{
        label: 'Bog Orchid'
        value: 'bog'
        traits: 
          colour: ["yellow-green"]
          habitat: ["marshes"]
      },{
        label: 'Coralroot Orchid'
        value: 'coralroot'
        traits: 
          colour: ["yellow-green"]
          habitat: ["coniforous", "dunes"]
      },{
        label: 'Lesser Twayblade'
        value: 'lesser-twayblade'
        traits: 
          colour: ["green-red"]
          habitat: ["coniforous", "heathland"]
      },{
        label: 'Bird\'s-nest Orchid'
        value: 'birds-nest'
        traits: 
          colour: ["brown"]
          habitat: ["deciduous"]
      },{
        label: 'Fly Orchid'
        value: 'fly'
        traits: 
          colour: ["multi"]
          habitat: ["deciduous", "grassland"]
      },{
        label: 'Bee Orchid'
        value: 'bee'
        traits: 
          colour: ["multi"]
          habitat: ["grassland"]
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