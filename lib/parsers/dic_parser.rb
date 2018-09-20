require_relative 'extension_error'

module Parsers
  class DicParser
    def initialize(file)
      @file = file
      @dictionary = {}
      @dictionary[:approx_word_count] = nil
      @dictionary[:words] = []
      @dictionary[:forbidden_words] = []
    end

    def parse
      validate_input_file_extension
      content = @file.to_a
      cleanup_content(content)
      word_count_try(content)
      fetch_words(content)
      @dictionary
    end

    private

    def validate_input_file_extension
      extension = File.extname(@file.to_path)
      raise ExtensionError, extension unless extension == '.dic'
    end

    def cleanup_content(content)
      content.map! do |line|
        remove_control_chars(line)
      end
    end

    def remove_control_chars(line)
      line.gsub(/[\n\t]/, '')
    end

    def word_count_try(content)
      @dictionary[:approx_word_count] = Integer(content.first)
      content.delete_at 0
    rescue ArgumentError
      nil
    end

    def fetch_words(content)
      content.each do |line|
        word, affixes = line.scan(%r{[*\w\s]*[^\/]})
        word.include?('*') ? add_to_forbidden(word) : add_to_words(word, affixes)
      end
    end

    def add_to_forbidden(word)
      @dictionary[:forbidden_words] << word.delete('*')
    end

    def add_to_words(word, affixes)
      @dictionary[:words] << { word: word, affixes: affixes }
    end
  end
end
