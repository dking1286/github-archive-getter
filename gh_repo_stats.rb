#!/usr/bin/env ruby

require_relative './arg_parser'
require_relative './url_generator'
require_relative './github_archive_service'
require_relative './output_formatter'

print 'Creating URLS...'
args = ArgParser.parse ARGV
urls = UrlGenerator.generate args[:after], args[:before]
puts 'Done!'

print 'Making requests to Github Archive...'
histogram = Hash.new(0)
responses = GithubArchiveService.get_each_response(urls)
response_data = responses.flatten
puts 'Done!'

print 'Processing response data...'
response_data.each do |event|
  next unless args[:event].nil? or event['type'] == args[:event]

  repo = GithubArchiveService.get_repo_name event
  if not repo.nil?
    key = GithubArchiveService.get_histogram_key repo
    histogram[key] += 1
  end
end
puts 'Done!'

histogram.to_a
  .sort {|a, b| b[1] <=> a[1]}
  .take(args[:count].nil? ? histogram.length : args[:count].to_i)
  .each do |entry|
    name, number = entry
    puts OutputFormatter.format name, number
  end

