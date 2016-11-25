require_relative './spec_helper.rb'

describe 'UrlGenerator' do
  describe '::generate' do
    it 'should exist' do
      expect(UrlGenerator.respond_to? :generate).to be true
    end

    it 'should generate the correct urls when given simple days and times' do
      after = '2012-11-01T13:00:00Z'
      before = '2012-11-01T15:00:00Z'

      expected = [
        'http://data.githubarchive.org/2012-11-01-13.json.gz',
        'http://data.githubarchive.org/2012-11-01-14.json.gz',
        'http://data.githubarchive.org/2012-11-01-15.json.gz'
      ]

      expect(UrlGenerator.generate after, before).to eql expected
    end

    it 'should generate the correct urls whe given a range including two days' do
      after = '2012-11-01T13:00:00Z'
      before = '2012-11-02T15:00:00Z'

      expected = []

      13.upto 23 do |number|
        expected.push "http://data.githubarchive.org/2012-11-01-#{number}.json.gz"
      end

      0.upto 15 do |number|
        expected.push "http://data.githubarchive.org/2012-11-02-#{number}.json.gz"
      end

      expect(UrlGenerator.generate after, before).to eql expected
    end
  end
end