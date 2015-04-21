module.exports = [{
    label: 'Species'
    content: '''
                 Identify the species by selecting from the photographs of the 29 species in the study. You can refine your selection by selecting flower colour and/or habitat from the drop down list
                 '''
    
    figures: [{
      label: '<a href="resources/OrchidObservers_IDGuide_FINAL.pdf">Download the idenitification guide (16.5MB PDF)</a>'
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
                  Tag insects by clicking on them – a text box window appears where you can add a name (if known). Don't worry if you can't identify the insects, we just want to know if an insect is present on the plant.
                   '''
      
      image: "examples/insects.jpg"
      alt: "Screenshot showing an insect being annotated."
    }]
  }]
