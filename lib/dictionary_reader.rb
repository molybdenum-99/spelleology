require_relative 'dictionary'
require_relative 'readers/files_from_agrs_reader'
require_relative 'parsers/dictionary_parser'
require_relative 'builders/dictionary_builder'

class DictionaryReader
  class << self
    def read(*args)
      dic_files = read_files_from_arguments(args)
      dic_files_data = get_data_from_dic_files(dic_files)
      create_dictionary(dic_files_data)
    end

    private

    def read_files_from_arguments(args)
      args.map do |arg|
        File.read(arg)
      end
    end

    def get_data_from_dic_files(dic_files)
      dic_files.each_with_object({}) do |file, acc|
        acc << Parsers::DictionaryParser.parse_file(file)
      end
    end

    def create_dictionary(data)
      Builders::DictionaryBuilder.build(data)
    end
  end
end
