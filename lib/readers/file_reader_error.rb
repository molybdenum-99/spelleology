module Readers
  class FileReaderError < StandardError
    def initialize(msg)
      super(msg)
    end
  end
end
