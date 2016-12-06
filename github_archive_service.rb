require 'zlib'
require 'json'

require 'typhoeus'

module GithubArchiveService
  def GithubArchiveService.get_each_response urls

    # Use Typhoeus::Hydra to make HTTP requests in parallel
    # for performance
    request_queue = Typhoeus::Hydra.new
    responses = []

    urls.each do |url|
      request = Typhoeus::Request.new(url, timeout: 15000)
      request.on_complete do |response|
        if response.success?
          responses.push(process_response response)
        end
      end

      request_queue.queue(request)
    end

    request_queue.run

    responses
  end

  def GithubArchiveService.get_repo_name event
    if event.has_key? 'repository'
      return {
        owner: event['repository']['owner'],
        repo_name: event['repository']['name']
      }
    elsif event.has_key? 'repo'
      owner, repo_name = event['repo']['name'].split("/")
      return {
        owner: owner,
        repo_name: repo_name
      }
    else
      nil
    end
  end

  def GithubArchiveService.get_histogram_key repo
    "#{repo[:owner]}/#{repo[:repo_name]}"
  end

  # Anonymous class to hold private helper methods
  class << self
    private

    def process_response response
      body = StringIO.new response.body
      unzipped = Zlib::GzipReader.new(body).read
      
      unzipped.split("\n").map {|str| JSON.parse str}
    end
  end
end