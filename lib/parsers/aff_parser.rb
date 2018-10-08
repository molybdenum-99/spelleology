# frozen_string_literal: true

module Parsers
  class AffParser
    AFFIX_REGEX = /^(PFX|SFX)(\s|\w|.)*/
    AFFIX_GROUP_REGEX = /^(PFX|SFX)\s\w/

    def initialize(file)
      @file = file
    end

    def parse
      {}.tap do |res|
        res[:affixes] = @file.to_a
                             .map { |ln| ln.tr("\n\t", '') }
                             .grep(AFFIX_REGEX)
                             .group_by { |el| el[AFFIX_GROUP_REGEX] }.values
                             .map(&method(:parse_affix_line))
      end
    end

    private

    def parse_affix_line(aff_group)
      header, *rule_lines = aff_group
      name, flag, cross_product, line_count = header.split(/[\s*]/)
      rules = fetch_rules(rule_lines)
      {
        name: name,
        flag: flag,
        cross_product: cross_product,
        line_count: line_count,
        rules: rules
      }
    end

    def fetch_rules(lines)
      lines.map do |el|
        _, _, stripping_rule, affixes, condition = el.split(/[\s*]/)
        { stripping_rule: stripping_rule, affixes: affixes, condition: condition }
      end
    end
  end
end
