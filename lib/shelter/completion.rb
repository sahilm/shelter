module Shelter
  class Completion
    COMPLETER = -> (input) do
      cmd = Shelter::CommandParser.new(Readline.line_buffer).parse
      cmd.complete(input)
    end
  end
end
