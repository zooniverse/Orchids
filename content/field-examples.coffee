module.exports = [{
    label: 'Species'
    content: '''
                 Identify the species by selecting from the photographs of the 29 species in the study. You can refine your selection by selecting flower colour and/or habitat from the drop down list
                 '''
    
    figures: [{
      label: ''
      image: "examples/species.jpg"
      alt: "Screenshot of the species identification tool."
    }]
  },{
    label: "Flowering stage"
    content: '''
                  Select ‘flowering stage’, click on the flower spike and label the flowering stage of the orchid in the photograph. There are 3 options:
                 '''
    figures: [{
      label: '''
                   <dl>
                                    <dt>Mainly in bud</dt>
                                    <dd>choose this if the spike is 50% or more in bud.</dd>
                                    <dt>Mainly in flower</dt>
                                    <dd>choose this if the spike is 50% or more in flower.</dd>
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
                  Tag the insect by clicking on it – a text box window appears where you can add your insect species identification (if known). You can use the common or scientific name e.g. <cite>‘Buff-tailed bumblebee’</cite> or <cite>Bombus terrestris</cite>.
                   '''
      
      image: "examples/insects.jpg"
      alt: "Screenshot showing an insect being annotated."
    }]
  }]
