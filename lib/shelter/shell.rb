module Shelter
  class Shell
    HISTORY_FILE = File.join(Dir.home, '.bash_history')
    PROMPT = "[#{File.basename(Dir.pwd)}] > "
    Readline.completion_append_character = nil
    Readline.basic_word_break_characters= " \t\n`><=;|&{("
    Readline.completer_word_break_characters = Readline.basic_word_break_characters + '.'
    Readline.completion_proc = Shelter::Completion::COMPLETER

    def run
      read_history
      while input = Readline.readline(PROMPT)
        input.strip!
        next if input.empty?
        Readline::HISTORY.push input
        cmd = Shelter::CommandParser.new(input).parse
        cmd.run rescue next
      end
    ensure
      write_history
    end

    private
    def write_history
      File.open(HISTORY_FILE, 'w') do |f|
        Readline::HISTORY.each { |line| f.puts line }
      end
    end

    def read_history
      File.foreach(HISTORY_FILE) do |cmd|
        Readline::HISTORY.push cmd
      end
    end
  end
end
