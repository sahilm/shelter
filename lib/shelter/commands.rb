module Shelter
  module Commands
    def complete_file_name(file_name)
      if File.directory?(file_name) && !file_name.end_with?('/')
        Dir["#{file_name}/*"]
      else
        Dir["#{file_name}*"]
      end
    end
  end
end

require 'shelter/commands/ruby'
require 'shelter/commands/builtin'
require 'shelter/commands/command'
