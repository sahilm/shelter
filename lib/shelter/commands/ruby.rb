module Shelter
  module Commands
    class Ruby
      attr_reader :cmd

      class << self
        def match?(cmd)
          cmd.start_with?('ruby')
        end
      end

      def initialize(cmd)
        @cmd = strip_ruby(cmd)
      end

      def complete(_)
        Readline.completer_word_break_characters = Readline.basic_word_break_characters
        if cmd =~ /\./
          method_completion
        elsif cmd =~ /^[A-Z]/
          constant_completion
        else
          []
        end
      rescue
        []
      end

      def run
        pid = fork do
          puts eval(cmd)
        end
        Process.waitpid(pid)
      end

      private
      def strip_ruby(cmd)
        cmd.gsub(/^ruby/, '').strip
      end

      def constant_completion
        ObjectSpace.each_object(Class).select do |klass|
          klass.to_s.start_with?(cmd)
        end.map(&:to_s)
      end

      def method_completion
        last_send_index = cmd.length - (cmd.reverse =~ /\./) - 1
        eval_string = cmd[0..last_send_index] + 'methods'
        pattern = cmd[last_send_index + 1..cmd.length]
        matching_methods(eval_string, pattern)
      end

      def matching_methods(eval_string, pattern=nil)
        reader, writer = IO.pipe
        pid = fork do
          STDERR.reopen('/dev/null')
          reader.close
          writer.write(eval(eval_string))
          writer.close
        end
        Process.waitpid(pid)
        writer.close
        methods = reader.gets.split(',').map { |m| m.strip[1..m.length] }
        reader.close
        if pattern
          methods.select { |m| m.start_with?(pattern) }
        else
          methods
        end
      end
    end
  end
end
