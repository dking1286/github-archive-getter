module Arg_Parser
  def self.parse args
    result = {}

    i = 0
    until i >= args.length
      self.validate_key args[i]
      result[self.to_key(args[i])] = args[i + 1]
      i += 2
    end

    result
  end

  def self.to_key arg
    arg.sub(/^--/, '').to_sym
  end

  def self.validate_key key
    raise ArgumentError, 'Each key must be preceded by "--"' unless key =~ /^--/
  end
end 