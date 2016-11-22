module ArgParser
  def ArgParser.parse args
    result = {}

    i = 0
    until i >= args.length
      validate_key args[i]
      result[to_key(args[i])] = args[i + 1]
      i += 2
    end

    result
  end
  
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
  end

end 