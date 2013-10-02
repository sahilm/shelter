module Shelter
  class Shell

    HISTORY_FILE = File.join(Dir.home, '.bash_history')
    BUILTINS = {
        'cd' => ->(dir=Dir.home) { Dir.chdir(dir) },
        'history' => -> { puts Readline::HISTORY.to_a }
    }
    Readline.completion_append_character = nil
    Readline.completion_proc = Shelter::FILE_NAME_COMPLETER
    def run
      read_history
      inputs = []
      while (buf = Readline.readline("[#{File.basename(Dir.pwd)}] > ", true))
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
