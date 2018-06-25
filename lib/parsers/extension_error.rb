class ExtensionError < StandardError
  attr_reader :extension
  def initialize(extension, msg = 'Wrong file extension')
    @extension = extension
    super(msg)
  end
end
