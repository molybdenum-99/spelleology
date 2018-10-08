require_relative '../lib/dictionary'

RSpec.describe Dictionary do
  subject { described_class }

  it 'should be OpenStruct' do
    expect(subject).to be < OpenStruct
  end
end
