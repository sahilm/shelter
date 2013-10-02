module Shelter
  module Commands
    class Ruby < Struct.new(:cmd)
      include Shelter::Commands
      class << self
        def ruby?(cmd)
          cmd.start_with?('``')
        end
      end

      def run
       ruby_cmd = "ruby -e #{Shellwords.shellescape(cmd[2..cmd.length].strip)}"
       execute(ruby_cmd)
      end
    end
  end
end
