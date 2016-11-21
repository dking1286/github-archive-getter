require 'open-uri'
require 'zlib'
require 'json'

zipped = open('http://data.githubarchive.org/2015-01-01-15.json.gz')
unzipped = Zlib::GzipReader.new(zipped).read
entries = unzipped.split("\n")

entries.each do |entry|
  puts JSON.parse(entry)
end