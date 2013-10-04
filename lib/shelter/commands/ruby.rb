module Shelter
  module Commands
    class Ruby < Struct.new(:cmd)
      class << self
        def match?(cmd)
          cmd.start_with?('``')
        end
      end

      def run
        pid = fork do
          puts eval(cmd[2..cmd.length].strip)
        end
        Process.waitpid(pid)
      end
    end
  end
end
