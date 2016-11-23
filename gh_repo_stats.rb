#!/usr/bin/env ruby

require_relative './arg_parser'
require_relative './url_generator'
require_relative './github_archive_service'
require_relative './output_formatter'

args = ArgParser.parse ARGV
urls = UrlGenerator.generate args[:after], args[:before]

histogram = Hash.new(0)
GithubArchiveService.get_response_data UrlGenerator::BASE_URL, urls do |response_data|
  response_data.each do |event|
    repo = GithubArchiveService.get_repo_name event
    if not repo.nil?
      key = GithubArchiveService.get_histogram_key repo
      histogram[key] += 1
    end
  end
end

histogram.to_a
  .sort {|a, b| b[1] <=> a[1]}
  .take(args[:count].to_i)
  .each do |entry|
    name, number = entry
    puts OutputFormatter.format name, number
  end
# events = urls.flat_map {|url| GithubArchiveService.get_raw_data url}

# histogram = GithubArchiveService.create_histogram(events, args[:event])

# histogram.to_a
#   .sort {|a, b| a[1] <=> b[1]}
#   .each {|entry| puts "#{entry[0]} - #{entry[1]} events"}
