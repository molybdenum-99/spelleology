module Parsers
  class DicParser
    def initialize(file)
      @file = file
    end

    def parse
      @file.to_a
           .map { |ln| ln.tr("\n\t", '') }
           .yield_self do |cnt|
             { approx_word_count: word_count_try(cnt) }.merge(fetch_words(cnt))
           end
    end

    private

    def word_count_try(content)
      Integer(content.first)
      content.delete_at 0
    rescue ArgumentError
      nil
    end

    def fetch_words(content)
      content.each_with_object({}) do |line, res|
        res[:words] ||= []
        res[:forbidden_words] ||= []
        word, affixes = line.scan(%r{[*\w\s]*[^\/]})
        if word.include?('*')
          res[:forbidden_words] << word.delete('*')
        else
          res[:words] << { word: word, affixes: affixes }
        end
      end
    end
  end
end
