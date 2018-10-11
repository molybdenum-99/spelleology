# frozen_string_literal: true

RSpec.shared_examples 'dictionary parser' do
  subject { described_class.parse(file_path) }

  context 'unsuccessfull cases:' do
    context 'file doesn\'t exist' do
      let(:file_path) { 'this/file/doesnt/exist' }

      it 'returns no_such_file error' do
        expect { subject }.to raise_error(Errno::ENOENT, /No such file or directory/)
      end
    end

    context 'input wrong type' do
      let(:file_path) { :some_symbol }

      it 'returns type error' do
        expect { subject }.to raise_error(TypeError, /no implicit conversion of/)
      end
    end

    context 'file not readable' do
      let(:file_path) { './spec/dictionaries/unreadable_file' }

      before do
        FileUtils.chmod 'u=,go=', file_path
      end

      after do
        FileUtils.chmod 'u=wr,go=rr', file_path
      end

      it 'returns permission error' do
        expect { subject }.to raise_error(Errno::EACCES, /Permission denied/)
      end
    end
  end
end
