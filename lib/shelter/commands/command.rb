module Shelter
  module Commands
    class Command
      include Shelter::Commands

      attr_reader :cmd, :args

      def initialize(cmd)
        @cmd, @args = Shellwords.shellsplit(cmd)
      end

      def run
        execute(cmd, *args)
      end
    end
  end
end
