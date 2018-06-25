require_relative 'extension_error'

module Parsers
  class DictionaryParser
    def initialize(file)
      @file = file
      @dictionary = {}
      @dictionary[:approx_word_count] = nil
      @dictionary[:words] = []
      @dictionary[:forbidden_words] = []
    end

    def parse
      # TODO: add other validations
      validate_input_file_extension
      first_line = remove_control_char(@file.first)
      first_line.to_i.zero? ? process_string(first_line) : rec_word_count(first_line.to_i)
      while (line = @file.gets)
        process_string(line)
      end
      @dictionary
    end

    private

    def validate_input_file_extension
      extension = File.extname(@file.to_path)
      raise ExtensionError, extension unless extension == '.dic'
    end

    def remove_control_char(line)
      line.delete!("\n")
    end

    def rec_word_count(number = nil)
      @dictionary[:approx_word_count] = number
    end

    def process_string(string)
      remove_control_char(string)
      word, affixes = string.scan(%r{[*\w\s]*[^\/]})
      word.include?('*') ? add_to_forbidden(word) : add_to_words(word, affixes)
    end

    def add_to_forbidden(word)
      @dictionary[:forbidden_words] << word
    end

    def add_to_words(word, affixes)
      @dictionary[:words] << { word: word, affixes: affixes }
    end
  end
end
