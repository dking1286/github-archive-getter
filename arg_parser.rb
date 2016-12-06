require 'date'

module ArgParser
  def ArgParser.parse args
    result = {}

    i = 0
    until i >= args.length
      validate_key args[i]
      result[to_key(args[i])] = args[i + 1]
      i += 2
    end

    include_default_args result
  end
  
  # Anonymous class to hold private helper methods
  class << self
    private

    def to_key arg
      arg.sub(/^--/, '').to_sym
    end

    def validate_key key
      unless key =~ /^--/
        raise ArgumentError, 'Each key must be preceded by "--"'
      end
    end

    def include_default_args args_hash
      defaults = {
        after: '2011-02-12T00:00:00Z',
        before: DateTime.now.to_s,
        count: 100,
        event: nil
      }

      args_with_defaults = {}
      args_with_defaults[:after] = args_hash[:after] || defaults[:after]
      args_with_defaults[:before] = args_hash[:before] || defaults[:before]
      args_with_defaults[:event] = args_hash[:event] || defaults[:event]
      args_with_defaults[:count] = args_hash[:count] || defaults[:count]

      args_with_defaults
    end
  end
end 