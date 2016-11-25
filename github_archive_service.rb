require 'net/http'
require 'zlib'
require 'json'

module GithubArchiveService
  def GithubArchiveService.create_histogram raw_data, event_name=nil
    raw_data.reduce(Hash.new(0)) do |result, entry|
      should_be_included = (event_name.nil? || event_name == entry['type'])

      result[entry['repo']['name']] += 1 if should_be_included
      
      result
    end
  end
  
  def GithubArchiveService.get_each_response base_url, urls
    base_uri_obj = URI(base_url)
    Net::HTTP.start(base_uri_obj.host, base_uri_obj.port) do |http|
      urls.each do |url|
        uri_obj = URI(url)

        request = Net::HTTP::Get.new uri_obj
        response = http.request request
        entries = process_response response

        yield entries
      end
    end
  end

  def GithubArchiveService.process_response response
    body = StringIO.new response.body
    unzipped = Zlib::GzipReader.new(body).read
    
    unzipped.split("\n").map {|str| JSON.parse str}
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
end