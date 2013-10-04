module Shelter
  class CommandParser < Struct.new(:cmd)

    def parse
      if Shelter::Commands::Builtin.match?(cmd)
        Shelter::Commands::Builtin.new(cmd)
      elsif Shelter::Commands::Ruby.match?(cmd)
        Shelter::Commands::Ruby.new(cmd)
      else
        Shelter::Commands::Command.new(cmd)
      end
    end
  end
end
