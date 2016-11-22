require 'date'

module UrlGenerator
  def UrlGenerator.generate after, before
    after_date_time = DateTime.parse after
    before_date_time = DateTime.parse before

    after_hour = after_date_time.hour
    before_hour = before_date_time.hour

    year = after_date_time.year
    month = to_two_digit(after_date_time.month)
    day = to_two_digit(after_date_time.day)

    "http://data.githubarchive.org/#{year}-#{month}-#{day}-{#{after_hour}..#{before_hour}}"
  end

  class << self
    private

    def to_two_digit num
      num < 10 ?
        '0' + num.to_s :
        num.to_s
    end
  end
end