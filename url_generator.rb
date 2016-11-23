require 'date'

module UrlGenerator
  
  def UrlGenerator.generate after, before
    after_dt = DateTime.parse after
    before_dt = DateTime.parse before

    after_dt.step(before_dt, 1/24.0).map do |datetime|
      year = datetime.year
      month = to_two_digit datetime.month
      day = to_two_digit datetime.day
      hour = datetime.hour

      url_string year, month, day, hour
    end
  end

  class << self
    private

    def url_string year, month, day, hour
      "http://data.githubarchive.org/#{year}-#{month}-#{day}-#{hour}.json.gz"
    end

    def to_two_digit num
      num < 10 ?
        '0' + num.to_s :
        num.to_s
    end
  end
end