# frozen_string_literal: true

require_relative '../../lib/parsers/aff_parser'
require_relative '../reference_parsers_results'
require_relative '../parsers_shared_examples'

RSpec.describe Parsers::AffParser do
  include_context 'reference_results'

  subject { described_class.parse(file_path) }

  it_behaves_like 'dictionary parser'

  let(:file_path) { './spec/dictionaries/test_affix.aff' }

  it 'returns hash' do
    expect(subject).to be_a_kind_of(Hash)
  end

  it 'returns reference result' do
    expect(subject).to eq reference_aff_result
  end
end
