module.exports = [{
    label: 'Species'
    content: '''
                 The thumbnails show the 29 species included in this survey. The colour and habitat filter tools can help you to narrow your search but your selections will not be recorded. We only record your final choice of species name. For more help identifying the orchids in this survey please see our <a href="resources/OrchidObservers_IDGuide_FINAL.pdf">Identification Guide (16.5MB PDF)</a>.
                 '''
    
    figures: [{
      label: 'Zoom in on the main image to see the flowers in close-up; flower shape and colour pattern are key identification features. Select the orchid that most closely matches the main image.'
      image: "examples/species.jpg"
      alt: "Screenshot of the species identification tool."
    }]
  },{
    label: "Flowering stage"
    content: '''
                  The top part of the plant, that has flowers, is called the flowering spike. Select ‘flowering stage’, click on the flowering spike and label the flowering stage of the orchid in the photograph. There are 3 options:
                 '''
    figures: [{
      label: '''
                 <dl>
                  <dt>Mainly in bud</dt>
                  <dd>choose this if more than half of the flowering spike is in bud.</dd>
                  <dt>Mainly in flower</dt>
                  <dd>choose this if more than half of the individual flowers on the flowering spike are open.</dd>
                  <dt>Flowering over/seed capsules</dt> 
                  <dd>choose this if you see seed capsules on the spike</dd>
                </dl>
                   '''
      
      image: "examples/field-flowering.jpg"
      alt: "Screenshot showing the flowering stage menu choices."
    }]
  },{
    label: "Insects"
    content: '''
                Do you see any insects on the flower?
                 '''
    figures: [{
      label: '''
                  Tag insects by clicking on them. Don't worry if you can't identify the insects, we just want to know if an insect is present on the plant.
                   '''
      
      image: "examples/insects.jpg"
      alt: "Screenshot showing an insect being annotated."
    }]
  }]
