module Shelter
  module Commands
    class Command
      include Shelter::Commands
      attr_reader :cmd, :args

      def initialize(cmd)
        @cmd, @args = Shellwords.shellsplit(cmd)
      end

      def run
        pid = fork do
          STDERR.reopen('/dev/null')
          exec cmd, *args
        end
        Process.waitpid(pid)
      end
    end
  end
end
