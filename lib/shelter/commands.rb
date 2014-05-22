module Shelter
  module Commands
    def complete(file_name)
      Readline.completer_word_break_characters = Readline.basic_word_break_characters
      pattern = file_name
      if File.directory?(file_name) && file_name !~ /(\.|\/)\z/
        pattern << '/*'
      else
        pattern << '*'
      end
      Dir[pattern]
    end
  end
end

require 'shelter/commands/ruby'
require 'shelter/commands/builtin'
require 'shelter/commands/command'
