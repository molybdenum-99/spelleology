# frozen_string_literal: true

module Parsers
  class AffParser
    class << self
      AFFIX_REGEX = /^(PFX|SFX)(\s|\w|.)*/
      AFFIX_GROUP_REGEX = /^(PFX|SFX)\s\w/

      def parse(file_path)
        {
          affixes: File.new(file_path)
                       .to_a
                       .map { |ln| ln.tr("\n\t", '') }
                       .grep(AFFIX_REGEX)
                       .group_by { |el| el[AFFIX_GROUP_REGEX] }.values
                       .map(&method(:parse_affix_line))
        }
      end

      def parse_affix_line(aff_group)
        header, *rule_lines = aff_group
        name, flag, cross_product, line_count = header.split(/[\s*]/)
        rules = rule_lines.map(&method(:make_rule))
        {
          name: name,
          flag: flag,
          cross_product: cross_product,
          line_count: line_count,
          rules: rules
        }
      end

      def make_rule(line)
        _, _, stripping_rule, affixes, condition = line.split(/[\s*]/)
        { stripping_rule: stripping_rule, affixes: affixes, condition: condition }
      end
    end
  end
end
