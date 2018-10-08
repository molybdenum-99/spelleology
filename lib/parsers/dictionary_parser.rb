# frozen_string_literal: true

require_relative 'dic_parser'
require_relative 'aff_parser'

module Parsers
  class DictionaryParser
    def self.parse_file(file)
      file_type = File.extname(file).delete('.')
      class_name = 'Parsers::' + file_type.to_s.capitalize + 'Parser'
      self.class.const_get(class_name).new(File.new(file)).parse
    end
  end
end
