module Shelter
  module Commands
    def execute(cmd, *args)
      pid = fork do
        exec cmd, *args
      end
      Process.waitpid(pid)
    end
  end
end

require 'shelter/commands/ruby'
require 'shelter/commands/builtin'
require 'shelter/commands/command'
