module Shelter
  FILE_NAME_COMPLETER = ->(input) do
    if File.directory?(input) && !input.end_with?('/')
      Dir["#{input}/*"]
    else
      Dir["#{input}*"]
    end
  end
end

require 'readline'
require 'shellwords'
require 'shelter/version'
require 'shelter/commands'
require 'shelter/command_parser'
require 'shelter/shell'
