module Shelter
  class Shell
    def run
      read_history
      cmds = []
      while (buf = Readline.readline('> ', true))
        cmds << buf
        p buf
      end
    ensure
      write_history(cmds)
    end

    private
    HISTORY_FILE = File.join(Dir.home, '.bash_history')

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
