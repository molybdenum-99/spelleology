require_relative '../../lib/readers/file_reader'

RSpec.describe Readers::FileReader do
  subject { described_class.new.call(input) }

  context 'failure cases:' do
    context 'when bad input' do
      let(:input) { :some_symbol }

      it 'returns validation failure' do
        expect(subject).to be_failure
      end
    end

    context 'when file doesn\'t exist' do
      let(:input) { './files/no_such_file.txt' }

      it 'returns non existance failure' do
        expect(subject).to be_failure
      end
    end

    context 'when file has zero size' do
      let(:input) { './spec/files/zero_size_file' }

      it 'returns non existance failure' do
        expect(subject).to be_failure
      end
    end

    context 'when file is not readable' do
      let(:input) { './spec/files/unreadable_file' }

      before do
        FileUtils.chmod 'u=,go=', input
      end

      after do
        FileUtils.chmod 'u=wr,go=rr', input
      end

      it 'returns non existance failure' do
        expect(subject).to be_failure
      end
    end
  end

  context 'success cases:' do
    let(:input) { './spec/files/test.dic' }

    it 'returns success' do
      expect(subject).to be_success
    end

    it 'returns file' do
      expect(subject.success).to be_an(File)
    end
  end
end
