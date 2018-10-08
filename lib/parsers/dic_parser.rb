# frozen_string_literal: true

module Parsers
  class DicParser
    WORD_AFF_REGEX = %r{^(\*?)([^\/]+)(?:\/(.+))?$}

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
      content.yield_self { |cnt| cnt - [word_count_try(cnt).to_s] }
             .map { |ln| ln.match(WORD_AFF_REGEX).values_at(1, 2, 3) }
             .map { |star, word, affixes| star == '*' ? word : { word: word, affixes: affixes } }
             .partition { |word| word.is_a?(String) }
             .yield_self do |forbidden, regular|
               { words: regular, forbidden_words: forbidden }
             end
    end
  end
end
