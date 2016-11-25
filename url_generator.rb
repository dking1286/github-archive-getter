require 'date'

module UrlGenerator
  BASE_URL = "http://data.githubarchive.org"
  ONE_HOUR = 1/24.0

  def UrlGenerator.generate after, before
    start_dt = DateTime.parse(after)
    finish_dt = DateTime.parse(before)

    if start_dt > finish_dt
      raise ArgumentError, "First argument #{after} is later than second argument #{before}"
    end

    (start_dt).step(finish_dt, ONE_HOUR).map do |datetime|
      year = datetime.year
      month = to_two_digit datetime.month
      day = to_two_digit datetime.day
      hour = datetime.hour

      url_string year, month, day, hour
    end
  end

  # Anonymous class to hold private helper methods
  class << self
    private

    def url_string year, month, day, hour
      BASE_URL + "/#{year}-#{month}-#{day}-#{hour}.json.gz"
    end

    def to_two_digit num
      num < 10 ?
        '0' + num.to_s :
        num.to_s
    end
  end
end