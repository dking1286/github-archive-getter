require 'open-uri'
require 'zlib'
require 'json'

require_relative './url_generator'

module GithubArchiveService
  def GithubArchiveService.create_histogram raw_data, event_name=nil
    raw_data.reduce(Hash.new(0)) do |result, entry|
      should_be_included = (event_name.nil? || event_name == entry['type'])

      result[entry['repo']['name']] += 1 if should_be_included
      
      result
    end
  end
  
  def GithubArchiveService.get_raw_data url
    zipped = open(url)
    unzipped = Zlib::GzipReader.new(zipped).read
    
    unzipped.split("\n").map {|entry| JSON.parse entry}
  end
end