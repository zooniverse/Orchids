#Update Orchid Observers with new uploads from the indicia database
1. Log in to `jenkins.zooniverse.org` and build a Manifest Data Processor (under the Ouroboros tab)
2. `ruby irecord.rb` to process new indicia data, and upload the photos to S3, along with a new `manifest.json` file.
3. Log in to `manifests.zooniverse.org` and create a new manifest for the Orchid Observers project. We've been naming them 
`orchids-field-yyyy-mm-dd` by date created. Use the URL of the manifest.json file that irecord.rb copies to S3 
(https://zooniverse-data.s3.amazonaws.com/project_data/orchids/manifest.json)
4. Run the manifest, following the prompts from the manifests app.
5. Once the manifest is run (should take about 5 minutes), log in to the AWS EC2 console and terminate the data processor that you built in step 1.
