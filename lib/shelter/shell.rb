module Shelter
  class Shell
    HISTORY_FILE = File.join(Dir.home, '.bash_history')
    BUILTINS = {
        'cd' => ->(dir=Dir.home) { Dir.chdir(dir) },
        'history' => -> { puts Readline::HISTORY.to_a }
    }
    def run
      read_history
      inputs = []
      while (buf = Readline.readline('> ', true))
        inputs << buf
        cmd, *args = Shellwords.shellsplit(buf)
        if BUILTINS.has_key?(cmd)
          BUILTINS[cmd].call(*args)
        else
          pid = fork do
            exec cmd, *args
          end
          Process.waitpid(pid)
        end
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
