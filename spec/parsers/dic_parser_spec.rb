require_relative '../../lib/parsers/dic_parser'
require_relative '../reference_parsers_results'

RSpec.describe Parsers::DicParser do
  include_context 'reference_results'

  subject { described_class.parse(file_path) }

  it_behaves_like 'dictionary parser'

  let(:file_path) { './spec/dictionaries/test_dict.dic' }

  it 'returns hash' do
    expect(subject).to be_a_kind_of(Hash)
  end

  it 'returns reference result' do
    expect(subject).to eq reference_dic_result
  end

  context 'personal dictionary' do
    let(:file_path) { './spec/dictionaries/test_personal.dic' }

    it 'returns reference result' do
      expect(subject).to eq reference_personal_dic_result
    end
  end
end
