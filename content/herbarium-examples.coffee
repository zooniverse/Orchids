module.exports = [{
    label: 'Barcode'
    content: '''
                 Each herbarium sheet is labelled with a barcode number. The barcode number is the unique identifier for each collection event. A collection event comprises one or more plant specimens collected from the same location on the same date – it is these specimens that you can see on the herbarium sheet.
                 '''
    
    figures: [{
      label: '''
                   Sometimes plant specimens from more than one collection event are mounted on the same herbarium sheet. When this happens there will be more than one barcode on the sheet. You will need to find the barcode that matches the barcode number we are asking you to look at. Use the magnifier tool to help you read the barcode.
                   '''
      
      image: "examples/barcode.jpg"
      alt: "Herbarium sheet with the barcode highlighted."
    },{
      label: '''
                   There is often more than one label on the herbarium sheet. Choose the label that includes the species name, date and location. This is usually in the bottom right hand corner of the sheet. Click and drag to draw a rectangle around the label. If your herbarium sheet contains more than one barcode, select the label that corresponds to the correct barcode. It will be positioned near the plant specimen(s) that are closest to the correct barcode.
                   '''
      
      image: "examples/label1x.jpg"
      alt: "Herbarium sheet with the label highlighted."
    }]
  },{
    label: "Specimen label"
    content: '''
                  Check and transcribe the label. 
                 '''
    figures: [{
      label: '''
        <dl>
          <dt>Species</dt>
          <dd>If no species name appears in the species field, please transcribe the species name verbatim as it appears on the label.
          <strong>Please note:</strong> Historical herbarium sheet labels often record a former name or names for a specimen which differ from the currently accepted name.</dd>
          <dt>Date</dt>
          <dd>Check that the date matches the label, if no date appears in the date field please enter the date in the format <strong>dd/mm/yyyy</strong>.  If more than one date appears on the label (or any other label on the sheet) we only want the specimen collection date recorded (other dates may refer to when the specimen was acquired by a herbarium, or when the specimen was determined or re-determined at a later date).</dd>
          <dt>Locality</dt>
          <dd>Check that the location matches the label. Correct it if necessary, or enter it if it has not been transcribed already.</dd>
        </dl>
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
                 The top part of the plant, that has flowers, is called the flowering spike. Estimate the flowering stage of the orchid specimen.  This can be difficult to tell in herbarium specimens, but don’t worry as lots of other people will also look at this same specimen. Click on the specimen (if there are more than one plant specimen choose the specimen closest to the barcode) and choose from the list of options:
                 
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
                    <dt>I don’t know</dt>
                    <dd>choose this if you cannot tell what the flowering stage is.</dd>
                  </dl>
                   '''
      
      image: "examples/herb-flowering.jpg"
      alt: "Screenshot showing the flowering stage menu choices."
    }]
  }]
