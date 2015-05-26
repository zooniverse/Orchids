require 'uri'
require 'json'
require 'csv'
require 'net/http'
require 'digest/sha1'
require 'aws-sdk'

S3_BUCKET = 'zooniverse-data'
S3_PATH = 'project_data/orchids'

class IndiciaWS
  
  def initialize()
    @warehouse_url = 'http://warehouse1.indicia.org.uk'
    @website_ID = 74
    @website_password = ENV['INDICIA_PWD']
  end

  def getReport( options )
    request = "#{@warehouse_url}/index.php/services/report/requestReport"
    options[:report] = "#{options[:report]}.xml" if options[:report][-4,4] != '.xml'
    
    params = {:report => options[:report], :reportSource => 'local'}
    options[:params] = options[:params].merge params
    self.get request, options
  end

  def get( request, options )
    auth = self.getAuth()
    options[:params] ||= {}
    auth_params = {:mode => 'json', :auth_token => auth[:read][:auth_token], :nonce => auth[:read][:nonce]}
    options[:params] = options[:params].merge auth_params

    uri = URI.parse request
    uri.query = URI.encode_www_form options[:params]
    response = Net::HTTP.get_response uri
    response.body
  end

  def getAuth()
    postargs = { :website_id => @website_ID }
    uri = URI.parse "#{@warehouse_url}/index.php/services/security/get_read_write_nonces"
    response = Net::HTTP.post_form uri, postargs
    nonces = JSON.parse response.body
    read_token = Digest::SHA1.hexdigest( "#{nonces['read']}:#{@website_password}" )
    write_token = Digest::SHA1.hexdigest( "#{nonces['write']}:#{@website_password}" )
    {:read => { :auth_token => read_token, :nonce => nonces['read'] }, :write => { :auth_token => write_token, :nonce => nonces['write'] } }
  end
  
  def getImage( input, output, directory = 'images' )
    Dir.mkdir(directory) unless File.exists?(directory)
    Net::HTTP.start("warehouse1.indicia.org.uk") { |http|
      resp = http.get("/upload/#{input}")
      open("#{directory}/#{output}" ,"wb") { |file|
        file.write(resp.body)
      }
    }
  end
end

metadata = {
  :occurrence_id => 'occurrence_id',
  :attr_sample_584 => 'username',
  :taxon => 'taxon',
  :common => 'common',
  :location_name => 'location_name',
  :vice_county => 'vice_county',
  :entered_sref => 'grid_ref',
  :date => 'date',
  :recorder => 'recorder',
  :certainty => 'certainty',
  :location_comment => 'comment'
}

client = Aws::S3::Client.new(
  access_key_id: ENV['AMAZON_ACCESS_KEY_ID'],
  secret_access_key: ENV['AMAZON_SECRET_ACCESS_KEY'],
  region: 'us-east-1'
)
s3 = Aws::S3::Resource.new(client: client)
bucket = s3.bucket(S3_BUCKET)
bucket_path = S3_PATH
bucket_path.sub(/^\//, '') if bucket_path

id_file = bucket.object("#{bucket_path}/orchid_ids.json").get().body
# id_file = File.open "orchid_ids.json", "a+"
ids = id_file.read()
unless ids.empty?
  saved = JSON.parse ids
else
  saved = []
end
puts saved
params = { "survey_id" => 294, "smpattrs" => '36,37,35,584', "occattrs" => '' }
ws = IndiciaWS.new()
response = ws.getReport( { :report => 'specific_surveys/zooniverse/orchid_observers/filterable_explore_list', :params => params } )
subjects = []
manifest = []
JSON.parse(response).each do |row|
  subject_id = row["occurrence_id"]
  unless saved.include? subject_id
    puts "processing #{subject_id}"
    subject = { 
      :type => "subject",
      :coords => [],
      :location => "",
      :metadata => {},
      :group_name => 'field',
    }
    csv_line = {}
    metadata.each do |field, label| 
      csv_line[label.to_sym] = row[field.to_s]
      subject[:metadata][label.to_sym] = row[field.to_s]
    end
    images = row["images"].split ',' if row['images']
    images ||= []
    location = []
    images.each_with_index do |image, i|
      ws.getImage image, "#{subject_id}_#{i}.jpg"
      file = {:filename => "#{subject_id}_#{i}.jpg"}
      file = file.merge csv_line
      subjects << file
      # options = { key: "#{bucket_path}/field/#{subject_id}_#{i}.jpg", content_type: "image/jpeg"}
      bucket.object("#{bucket_path}/field/#{subject_id}_#{i}.jpg").upload_file("./images/#{subject_id}_#{i}.jpg")
      location << "http://s3.amazonaws.com/#{S3_BUCKET}/#{S3_PATH}/field/#{subject_id}_#{i}.jpg"
    end
    case location.length
    when 0
      subject[:location] = nil
    when 1
      subject[:location] = location[0]
    else
      subject[:location] = location
    end
    manifest << subject unless subject[:location].nil?
    saved << csv_line[:occurrence_id]
  end
end
File.write 'manifest.json', JSON.generate( manifest )
File.write 'orchid_ids.json', JSON.generate( saved )
csv_headings = ['filename']
metadata.each do |heading, label| 
  csv_headings << label
end
puts csv_headings
CSV.open( "filelist.csv", "w" ) do |csv|
  csv << csv_headings
  subjects.each do |subject|
    csv << subject.values
  end
end

bucket.object("#{bucket_path}/manifest.json").upload_file("./manifest.json")
bucket.object("#{bucket_path}/orchid_ids.json").upload_file("./orchid_ids.json")
bucket.object("#{bucket_path}/filelist.csv").upload_file("./filelist.csv")

