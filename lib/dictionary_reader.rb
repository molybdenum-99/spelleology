# frozen_string_literal: true

require_relative 'parsers/dic_parser'
require_relative 'parsers/aff_parser'
require_relative 'dictionary'

class DictionaryReader
  class << self
    def read(aff_path, dic_path)
      aff = Parsers::AffParser.parse(aff_path)
      dic = Parsers::DicParser.parse(dic_path)
      Dictionary.new(aff, dic)
    end
  end
end
