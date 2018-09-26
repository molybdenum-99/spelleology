module Parsers
  class DicParser
    WORD_AFF_REGEX = %r{[*\w\s]*[^\/]}

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
    rescue ArgumentError
      nil
    end

    def fetch_words(content)
      content[1..-1].each_with_object({}) do |line, res|
        res[:words] ||= []
        res[:forbidden_words] ||= []
        word, affixes = line.scan(WORD_AFF_REGEX)
        if word.include?('*')
          res[:forbidden_words] << word.delete('*')
        else
          res[:words] << { word: word, affixes: affixes }
        end
      end
    end
  end
end
