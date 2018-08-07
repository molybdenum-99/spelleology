require_relative '../../lib/parsers/affix_parser'

RSpec.describe Parsers::AffixParser do
  context 'validations' do
    context 'validate input file extension' do
      it 'raises exception when file extension is wrong' do
        input_file = File.new(Dir.pwd + '/spec/dictionaries/test_file.wrong_extension')
        expect { Parsers::AffixParser.new(input_file).parse }.to raise_error(ExtensionError)
      end
    end
  end
end
