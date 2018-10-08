# frozen_string_literal: true

require_relative 'parsers/dictionary_parser'
require_relative 'dictionary'

class DictionaryReader
  class << self
    def read(*args)
      dic_files = read_files_from_arguments(args)
      dic_files_data = get_data_from_dic_files(dic_files)
      create_dictionary(dic_files_data)
    end

    private

    def read_files_from_arguments(args)
      args.map(&File.method(:new))
    end

    def get_data_from_dic_files(dic_files)
      dic_files.inject({}) do |acc, file|
        acc.merge(Parsers::DictionaryParser.parse_file(file))
      end
    end

    def create_dictionary(data)
      Dictionary.new(data)
    end
  end
end
