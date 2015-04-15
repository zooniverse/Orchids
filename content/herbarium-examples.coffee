module.exports = [{
    label: 'Barcode'
    content: '''
                 Each herbarium specimen is labelled with a barcode number. This is the unique specimen identifier.
                 '''
    
    figures: [{
      label: '''
                   Verify the specimen number. The Barcode is a unique specimen identifier and is usually located in the top left hand corner of the specimen sheet. For multiple collection records mounted on the same sheet, each will have a barcode identifying the specimen (the ‘collection event’).   Check that the specimen number matches the barcode nearest to the specimen. Use the magnifier tool to help you read the numbers on the barcode.
                   '''
      
      image: "examples/barcode.jpg"
      alt: "Herbarium sheet with the barcode highlighted."
    }]
  },{
    label: "Specimen label"
    content: '''
                  Select the label. 
                 '''
    figures: [{
      label: '''
                   There may be more than one label per specimen on the sheet. Choose the correct label as shown here, giving the species name, date and location. This is usually in the bottom right hand corner of the herbarium sheet. Where there are multiple collections from different locations mounted on the same sheet, the barcode associated to the correct specimen will normally be positioned nearest to it.  Click and drag to draw a rectangle around the label.
                   '''
      
      image: "examples/label1x.jpg"
      alt: "Herbarium sheet with the label highlighted."
    },{
      label: '''
                   <p>Check and transcribe the label.</p>
                   <p>If no species name appears in the species field, please transcribe the species name verbatim as it appears on the label.
                   <strong>Please note:</strong> Historical herbarium sheet labels often record a former name or names for a specimen which differ from the currently accepted name.</p>

                   <p>Check that the date matches the label, if no date appears in the date field please enter the date in the format <strong>dd/mm/yyyy</strong>.  If more than one date appears on the label (or any other label on the sheet) we only want the specimen collection date recorded (other dates may refer to when the specimen was acquired by a herbarium, or when the specimen was determined or re-determined at a later date).</p>
                   
                   <p>Check that the location matches the label. Correct it if necessary, or enter it if it has not been transcribed already.</p>
                    
                   '''
      
      image: "examples/label2.jpg"
      alt: "Herbarium sheet with the label highlighted."
    }]
  },{
    label: "Vice county"
    content: '''
                 Next, look for the Vice County (VC) number on the specimen sheet. For this task you may want to use the zoom in button. This annotation can be hard to spot. It is usually written in pencil somewhere along the right hand margin of the sheet (or may sometimes be recorded on the specimen label itself).
                 '''
    figures: [{
      label: ''
      image: "examples/vcx.jpg"
      alt: "Example of a vice county number."
    }]
  },{
    label: "Flowering stage"
    content: '''
                 Estimate the flowering stage of the orchid specimen. Click on the specimen (if there are more than one plant specimen choose the specimen closest to the barcode) and choose from the list of options:
                 
                 '''
    figures: [{
      label: '''
                   <dl>
                                    <dt>Mainly in bud</dt>
                                    <dd>choose this if the spike has 50% or more flower buds than open flowers.</dd>
                                    <dt>Mainly in flower</dt>
                                    <dd>choose this if the spike has 50% or more open flowers.</dd>
                                    <dt>Flowering over/seed capsules</dt> 
                                    <dd>choose this if you see any seed capsules on the spike [illustration of orchid seed capsule?]</dd>
                                    <dt>I don’t know</dt>
                                    <dd>choose this if you cannot tell what the flowering stage is.</dd>
                                    </dl>
                   '''
      
      image: "examples/herb-flowering.jpg"
      alt: "Screenshot showing the flowering stage menu choices."
    }]
  }]
