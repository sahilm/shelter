module Shelter
  class CommandParser < Struct.new(:cmd)

    def parse
      if Shelter::Commands::Builtin.builtin?(cmd)
        Shelter::Commands::Builtin.new(cmd)
      elsif Shelter::Commands::Ruby.ruby?(cmd)
        Shelter::Commands::Ruby.new(cmd)
      else
        Shelter::Commands::Command.new(cmd)
      end
    end
  end
end
