require_relative '../../lib/parsers/dictionary_parser'

RSpec.describe Parsers::DictionaryParser do
  subject { described_class.parse_file(file) }

  context 'unknown dictionary format' do
    let(:file) { File.read('./spec/dictionaries/test_file.wrong_extension') }

    it 'returns no_such_parser error' do
      expect { subject }.to raise_error(NameError, /uninitialized constant/)
    end
  end

  context 'correct input' do
    context 'aff file input' do
      let(:file) { File.new('./spec/dictionaries/test_affix.aff') }

      it 'returns hash' do
        expect(subject).to be_a_kind_of(Hash)
      end
    end

    context 'dic file input' do
      let(:file) { File.new('./spec/dictionaries/test_dict.dic') }

      it 'returns hash' do
        expect(subject).to be_a_kind_of(Hash)
      end
    end
  end
end
