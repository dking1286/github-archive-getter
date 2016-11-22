require_relative './spec_helper'

describe 'ArgParser' do
  describe '::parse' do
    it 'should correctly parse the command line args' do
      fake_argv = ['--hello', 'world']
      expected = {hello: 'world'}

      expect(ArgParser.parse fake_argv).to eql expected
    end

    it 'should correctly parse multiple args' do
      fake_argv = ['--hello', 'world', '--how', 'areyou']
      expected = {hello: 'world', how: 'areyou'}

      expect(ArgParser.parse fake_argv).to eql expected
    end

    it 'should throw an error if no key is provided for any arg' do
      fake_argv = ['world', '--how', 'areyou']
      
      expect {ArgParser.parse fake_argv}.to raise_error(ArgumentError)
    end

    it 'should keep helper methods private' do
      expect {ArgParser.validate_key '--hello'}.to raise_error(NoMethodError)
    end
  end
  
end