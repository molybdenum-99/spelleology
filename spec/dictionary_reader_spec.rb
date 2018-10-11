# frozen_string_literal: true

require_relative '../lib/dictionary_reader'
require_relative './reference_parsers_results'

RSpec.describe DictionaryReader do
  include_context 'reference_results'

  subject { described_class.read(aff_path, dic_path) }

  # context 'unsuccessfull cases:' do
  #   context 'file doesn\'t exist' do
  #     let(:aff_path) { 'this/file/doesnt/exist' }
  #     let(:dic_path) { 'this/file/doesnt/exist' }

  #     it 'returns no_such_file error' do
  #       expect { subject }.to raise_error(Errno::ENOENT, /No such file or directory/)
  #     end
  #   end

  #   context 'input wrong type' do
  #     let(:aff_path) { :some_symbol }
  #     let(:dic_path) { :some_symbol }

  #     it 'returns type error' do
  #       expect { subject }.to raise_error(TypeError, /no implicit conversion of/)
  #     end
  #   end

  #   context 'file not readable' do
  #     let(:args) { './spec/dictionaries/unreadable_file' }

  #     before do
  #       FileUtils.chmod 'u=,go=', args
  #     end

  #     after do
  #       FileUtils.chmod 'u=wr,go=rr', args
  #     end

  #     it 'returns permission error' do
  #       expect { subject }.to raise_error(Errno::EACCES, /Permission denied/)
  #     end
  #   end
  # end

  context 'successfull cases' do
    let(:aff_path) { './spec/dictionaries/test_affix.aff' }
    let(:dic_path) { './spec/dictionaries/test_dict.dic' }

    let(:result) do
      Dictionary.new(reference_aff_result, reference_dic_result)
    end

    it 'returns Dictionary type' do
      expect(subject).to be_a(Dictionary)
    end

    it 'returns reference result' do
      expect(subject).to eq result
    end
  end
end
