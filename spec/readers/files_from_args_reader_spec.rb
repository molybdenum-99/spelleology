require_relative '../../lib/readers/files_from_args_reader'
require_relative '../../lib/readers/file_reader_error'

RSpec.describe Readers::FilesFromArgsReader do
  subject { described_class.read(args) }

  context 'error cases:' do
    let(:error) { Readers::FileReaderError }

    context 'when bad input' do
      let(:args) { :some_symbol }
      let(:error_message) { '{:file_path=>["must be String"]}' }

      it 'returns error with validation message' do
        expect { subject }.to raise_error(error, error_message)
      end
    end

    context 'when file doesn\'t exist' do
      let(:args) { './spec/files/no_such_file.txt' }
      let(:error_message) { "there is no file this path: #{args} or it is not regular" }

      it 'returns error with non_existance error' do
        expect { subject }.to raise_error(error, error_message)
      end
    end

    context 'when file has zero size' do
      let(:args) { './spec/files/zero_size_file' }
      let(:error_message) { "file on path #{args} has zero size" }

      it 'returns error with zero size' do
        expect { subject }.to raise_error(error, error_message)
      end
    end

    context 'when file is not readable' do
      let(:args) { './spec/files/unreadable_file' }
      let(:error_message) { "file on path #{args} is not readable" }

      before do
        FileUtils.chmod 'u=,go=', args
      end

      after do
        FileUtils.chmod 'u=wr,go=rr', args
      end

      it 'returns error with not readable message' do
        expect { subject }.to raise_error(error, error_message)
      end
    end
  end

  context 'success cases:' do
    let(:args) { './spec/files/test.dic' }

    it 'returns array of files' do
      expect(subject).to be_an(Array)
      expect(subject).to include(a_kind_of(File))
    end
  end
end
