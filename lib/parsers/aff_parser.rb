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
      header = aff_group.first
      name, flag, cross_product, line_count = header.split(/[\s*]/)
      rules = aff_group[1..-1].each_with_object([]) do |el, arr|
        _, _, stripping_rule, affixes, condition = el.split(/[\s*]/)
        arr << { stripping_rule: stripping_rule, affixes: affixes, condition: condition }
      end
      {
        name: name,
        flag: flag,
        cross_product: cross_product,
        line_count: line_count,
        rules: rules
      }
    end
  end
end
