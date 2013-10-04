module Shelter
  class CommandParser < Struct.new(:cmd)
    DEFAULT_COMMAND = -> { Shelter::Commands::Command }

    def parse
      commands.detect(DEFAULT_COMMAND) do |command|
        command.match?(cmd)
      end.new(cmd)
    end

    private
    def commands
      @commands ||= _commands
    end

    def _commands
      Shelter::Commands.constants.inject([]) do |memo, constant|
        c = Shelter::Commands.const_get(constant)
        memo << c if c.respond_to?(:match?)
        memo
      end
    end
  end
end
