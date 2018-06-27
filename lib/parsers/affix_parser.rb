require_relative 'extension_error'

# TODO: implement base parser class for common interface
module Parsers
  class AffixParser
    def initialize(file)
      @file = file
      @affixes = {}
      @affixes[:affixes] = []
    end

    def parse
      # TODO: add other validations
      validate_input_file_extension
      content = @file.to_a
      cleanup_content(content)
      affixes = fetch_affixes(content)
      @affixes[:affixes] = objectize_affixes_from_array(affixes)
      @affixes
    end

    private

    def validate_input_file_extension
      extension = File.extname(@file.to_path)
      raise ExtensionError, extension unless extension == '.aff'
    end

    def cleanup_content(content)
      content.map! do |line|
        remove_control_chars(line)
      end
    end

    def remove_control_chars(line)
      line.gsub(/[\n\t]/, '')
    end

    def fetch_affixes(content)
      affix = 'PFX|SFX'
      affixes = content.select do |line|
        line.match(affix)
      end
      affixes.group_by do |line|
        line[/^#{affix}\s\w/]
      end.values
    end

    def objectize_affixes_from_array(affixes)
      affixes.map do |affix|
        header = affix.delete_at 0
        name, flag, cross_product, line_count = header.split(/[\s*]/)
        rules = []
        affix.each do |el|
          _, _, stripping_rule, affixes, condition = el.split(/[\s*]/)
          rules << { stripping_rule: stripping_rule, affixes: affixes, condition: condition }
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
end
