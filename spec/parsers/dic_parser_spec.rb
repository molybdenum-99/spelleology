require_relative '../../lib/parsers/dic_parser'
require_relative '../reference_parsers_results'

RSpec.describe Parsers::DicParser do
  include_context 'reference_results'

  let(:file) { File.new('./spec/dictionaries/test_dict.dic') }

  subject { described_class.new(file).parse }

  it 'returns hash' do
    expect(subject).to be_a_kind_of(Hash)
  end

  it 'returns reference result' do
    expect(subject).to eq reference_dic_result
  end
end
