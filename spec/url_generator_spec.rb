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
  end
end