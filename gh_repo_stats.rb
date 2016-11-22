#!/usr/bin/env ruby

require_relative './arg_parser'
require_relative './url_generator'
require_relative './github_archive_service'

args = ArgParser.parse ARGV
urls = UrlGenerator.generate args[:after], args[:before]

events = urls.flat_map {|url| GithubArchiveService.get_raw_data url}

histogram = GithubArchiveService.create_histogram(events, args[:event])

histogram.to_a
  .sort {|a, b| a[1] <=> b[1]}
  .each {|entry| puts "#{entry[0]} - #{entry[1]} events"}
