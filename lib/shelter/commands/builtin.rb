module Shelter
  module Commands
    class Builtin
      BUILTINS = {
          'cd' => ->(dir=Dir.home) { Dir.chdir(dir) },
          'history' => -> { puts Readline::HISTORY.to_a }
      }

      class << self
        def builtin?(cmd)
          command, _ = Shellwords.shellsplit(cmd)
          BUILTINS.has_key?(command)
        end
      end

      attr_reader :cmd, :args

      def initialize(cmd)
        @cmd, @args = Shellwords.shellsplit(cmd)
      end

      def run
        BUILTINS[cmd].call(*args)
      end
    end
  end
end
