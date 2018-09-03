module Parsers
  class DictionaryReaderArgsParser
    class << self
      def parse(*args)
        args.map do |file_path|
          FileReader.new.call(file_path)
        end
      end

      private

      def read_file(file_path)
        result = FileReader.new.call(file_path)

        result.success? ? result.success : raise_read_error(result.failure)
      end

      def raise_read_error(message)
        raise DictionaryReaderArgsParserError, message.to_s
      end
    end

    class DictionaryReaderArgsParserError < StandardError
      def initialize(msg)
        super(msg)
      end
    end

    class FileReader
      require 'dry/monads/result'
      require 'dry/monads/do'
      require 'dry-validation'

      include Dry::Monads::Result::Mixin
      include Dry::Monads::Do.for(:call)

      Schema = Dry::Validation.Schema do
        required(:file_path) { filled? && type?(String) }
      end

      def call(file_path)
        yield validate_input(file_path: file_path)
        yield validate_file_existance(file_path)
        yield validate_file_non_zero_size(file_path)
        yield validate_file_readable(file_path)
        read_file(file_path)
      end

      private

      def validate_input(input)
        validation = Schema.call(input)

        validation.success? ? Success(input) : Failure(validation.messages)
      end

      def validate_file_existance(file_path)
        validation = File.file?(file_path)

        validation ? Success(file_path) : Failure("there is no file this path: #{file_path} or it is not regular")
      end

      def validate_file_non_zero_size(file_path)
        validation = File.zero?(file_path)

        validation ? Success(file_path) : Failure("file on path #{file_path} has zero size")
      end

      def validate_file_readable(file_path)
        validation = File.readable_real?(file_path)

        validation ? Success(file_path) : Failure("file on path #{file_path} is not readable")
      end

      def read_file(file_path)
        file = File.new(file_path, 'r')

        Success(file)
      rescue StandardError => e
        Failure("cant't read file, error: #{e}")
      end
    end
  end
end
