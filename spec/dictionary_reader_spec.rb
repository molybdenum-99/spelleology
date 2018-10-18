# frozen_string_literal: true

require_relative '../lib/dictionary_reader'
require_relative './reference_parsers_results'

RSpec.describe DictionaryReader do
  include_context 'reference_results'

  subject { described_class.read(aff_path, dic_path) }

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
