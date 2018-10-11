# frozen_string_literal: true

module Parsers
  class DicParser
    class << self
      WORD_AFF_REGEX = %r{^(\*?)([^\/]+)(?:\/(.+))?$}
      INTEGER_REGEX = /^[0-9]*$/

      def parse(file_path)
        File.new(file_path)
            .to_a
            .map { |ln| ln.tr("\n\t", '') }
            .yield_self do |cnt|
              try_wordcount(cnt).yield_self do |count, words|
                { approx_word_count: count }.merge(fetch_words(words))
              end
            end
      end

      def try_wordcount(lines)
        lines.first.match?(INTEGER_REGEX) ? [lines.first.to_i, lines[1..-1]] : [nil, lines]
      end

      def fetch_words(content)
        content.map { |ln| ln.match(WORD_AFF_REGEX).values_at(1, 2, 3) }
               .map { |star, word, affixes| star == '*' ? word : { word: word, affixes: affixes } }
               .partition { |word| word.is_a?(String) }
               .yield_self do |forbidden, regular|
                 { words: regular, forbidden_words: forbidden }
               end
      end
    end
  end
end
