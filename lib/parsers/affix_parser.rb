require_relative 'extension_error'

module Parsers
  class AffixParser
    def initialize(file)
      @file = file
      @affixes = {}
    end
  end
end
