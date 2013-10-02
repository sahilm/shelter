module Shelter
  class Shell
    HISTORY_FILE = File.join(Dir.home, '.bash_history')
    Readline.completion_append_character = nil
    Readline.completion_proc = Shelter::FILE_NAME_COMPLETER

    def run
      read_history
      inputs = []
      while (buf = Readline.readline("[#{File.basename(Dir.pwd)}] > ", true))
        inputs << buf
        cmd = Shelter::CommandParser.new(buf).parse
        cmd.run
      end
    ensure
      write_history(inputs)
    end

    private
    def write_history(cmds)
      File.open(HISTORY_FILE, 'a') do |f|
        f.puts cmds.join("\n")
      end
    end

    def read_history
      File.readlines(HISTORY_FILE).each do |cmd|
        Readline::HISTORY.push cmd
      end
    end
  end
end
