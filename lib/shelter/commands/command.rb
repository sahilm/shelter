module Shelter
  module Commands
    class Command
      include Shelter::Commands
      attr_reader :cmd, :args

      def initialize(cmd)
        @cmd, @args = Shellwords.shellsplit(cmd)
      end

      def complete(file_name)
        complete_file_name(file_name)
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
