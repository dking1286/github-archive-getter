require_relative './spec_helper.rb'

describe 'UrlGenerator' do
  describe '::generate' do
    it 'should exist' do
      expect(UrlGenerator.respond_to? :generate).to be true
    end

    it 'should generate the correct url when given a simple day and time' do
      after = '2012-11-01T13:00:00Z'
      before = '2012-11-01T15:00:00Z'

      expected = ['http://data.githubarchive.org/2012-11-01-{13..15}']

      expect(UrlGenerator.generate after, before).to eql expected
    end

    it 'should generate the correct urls whe given a range including two days' do
      after = '2012-11-01T13:00:00Z'
      before = '2012-11-02T15:00:00Z'

      expected = [
        'http://data.githubarchive.org/2012-11-01-{13..23}',
        'http://data.githubarchive.org/2012-11-02-{0..15}'
      ]

      expect(UrlGenerator.generate after, before).to eql expected
    end

    it 'should generate the correct urls when given a more complicated set of dates' do
      after = '2012-11-01T13:00:00Z'
      before = '2012-11-03T15:00:00Z'

      expected = [
        'http://data.githubarchive.org/2012-11-01-{13..23}',
        'http://data.githubarchive.org/2012-11-02-{0..23}',
        'http://data.githubarchive.org/2012-11-03-{0..15}'
      ]

      expect(UrlGenerator.generate after, before).to eql expected
    end
  end
end