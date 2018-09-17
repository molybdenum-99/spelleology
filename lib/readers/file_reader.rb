module Readers
  class FileReader
    require_relative '../modules/validation'
    require 'dry/monads/result'
    require 'dry/monads/do'
    require 'dry-validation'

    include Dry::Monads::Result::Mixin
    include Dry::Monads::Do.for(:call)

    include Validation

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

    def validate_file_existance(file_path)
      validation = File.file?(file_path)

      validation ? Success(file_path) : Failure("there is no file this path: #{file_path} or it is not regular")
    end

    def validate_file_non_zero_size(file_path)
      validation = File.zero?(file_path)

      validation ? Failure("file on path #{file_path} has zero size") : Success(file_path)
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
