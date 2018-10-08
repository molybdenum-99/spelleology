require_relative '../lib/dictionary_reader'
require_relative './reference_parsers_results'

RSpec.describe DictionaryReader do
  include_context 'reference_results'

  subject { described_class.read(*args) }

  context 'unsuccessfull cases:' do
    context 'file doesn\'t exist' do
      let(:args) { 'this/file/doesnt/exist' }

      it 'returns no_such_file error' do
        expect { subject }.to raise_error(Errno::ENOENT, /No such file or directory/)
      end
    end

    context 'input wrong type' do
      let(:args) { :some_symbol }

      it 'returns type error' do
        expect { subject }.to raise_error(TypeError, /no implicit conversion of/)
      end
    end

    context 'file not readable' do
      let(:args) { './spec/dictionaries/unreadable_file' }

      before do
        FileUtils.chmod 'u=,go=', args
      end

      after do
        FileUtils.chmod 'u=wr,go=rr', args
      end

      it 'returns permission error' do
        expect { subject }.to raise_error(Errno::EACCES, /Permission denied/)
      end
    end
  end

  context 'successfull cases' do
    let(:args) { ['./spec/dictionaries/test_affix.aff', './spec/dictionaries/test_dict.dic'] }
    let(:result) do
      Dictionary.new(reference_reader_result)
    end

    it 'returns Dictionary type' do
      expect(subject).to be_a(Dictionary)
    end

    it 'returns reference result' do
      expect(subject).to eq result
    end
  end
end
