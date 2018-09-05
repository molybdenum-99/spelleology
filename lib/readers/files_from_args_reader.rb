module Readers
  class FilesFromArgsReader
    class << self
      def read(*args)
        args.map do |file_path|
          read_file(file_path)
        end
      end

      private

      def read_file(file_path)
        result = FileReader.new.call(file_path)

        result.success? ? result.success : raise_read_error(result.failure.to_s)
      end

      def raise_read_error(context)
        raise Readers::FileReaderError, context
      end
    end
  end
end
