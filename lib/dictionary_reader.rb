require_relative 'dictionary'
require_relative 'parsers/dictionary_parser'
require_relative 'parsers/affix_parser'

class DictionaryReader
  class << self
    def read(dic_file_path, aff_file_path)
      dic = parse_dic(dic_file_path)
      aff = parse_aff(aff_file_path)
      result = dic.merge aff
      create_dictionary_object(result)
    end

    private

    def parse_dic(dic_file_path)
      dic_file = File.new(dic_file_path)
      Parsers::DictionaryParser.new(dic_file).parse
    end

    def parse_aff(aff_file_path)
      aff_file = File.new(aff_file_path)
      Parsers::AffixParser.new(aff_file).parse
    end

    def create_dictionary_object(result)
      Dictionary.new(approx_word_count: result[:approx_word_count],
                     words: result[:words],
                     forbidden_words: result[:forbidden_words],
                     affixes: result[:affixes])
    end
  end
end
