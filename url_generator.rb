require 'date'

module UrlGenerator
  def UrlGenerator.generate after, before
    after_date_time = DateTime.parse after
    before_date_time = DateTime.parse before

    duration_in_days = before_date_time.day - after_date_time.day + 1

    case duration_in_days
    when 1
      generate_single_day_url after_date_time, before_date_time
    when 2
      generate_two_day_urls after_date_time, before_date_time
    else
      generate_multi_day_urls after_date_time, before_date_time
    end
  end

  class << self
    private

    def generate_single_day_url after_date_time, before_date_time
      year = after_date_time.year
      month = after_date_time.month
      day = to_two_digit(after_date_time.day)
      hour = "{#{after_date_time.hour}..#{before_date_time.hour}}"

      [url_string(year, month, day, hour)]
    end

    def generate_two_day_urls after_date_time, before_date_time
      after_year = after_date_time.year
      after_month = after_date_time.month
      after_day = to_two_digit(after_date_time.day)
      after_hour = "{#{after_date_time.hour}..23}"

      before_year = before_date_time.year
      before_month = before_date_time.month
      before_day = to_two_digit(before_date_time.day)
      before_hour = "{0..#{before_date_time.hour}}"

      [
        url_string(after_year, after_month, after_day, after_hour),
        url_string(before_year, before_month, before_day, before_hour)
      ]
    end

    def generate_multi_day_urls after_date_time, before_date_time
      result = []
      after_date_time.next_day.upto before_date_time.prev_day do |date|
        year, month, day = date.year, date.month, to_two_digit(date.day)
        result.push url_string(year, month, day, "{0..23}")
      end

      first, last = generate_two_day_urls after_date_time, before_date_time

      result.unshift(first).push(last)
    end

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