RSpec.shared_context 'reference_results' do
  let(:reference_aff_result) do
    {
      affixes: [
        {
          name: 'PFX',
          flag: 'A',
          cross_product: 'Y',
          line_count: '1',
          rules:
          [
            {
              stripping_rule: '0',
              affixes: 're',
              condition: '.'
            }
          ]
        },
        {
          name: 'SFX',
          flag: 'B',
          cross_product: 'Y',
          line_count: '2',
          rules:
          [
            {
              stripping_rule: '0',
              affixes: 'ed',
              condition: '[^y]'
            },
            {
              stripping_rule: 'y',
              affixes: 'ied',
              condition: 'y'
            }
          ]
        }
      ]
    }
  end

  let(:reference_dic_result) do
    {
      approx_word_count: 3,
      words:
      [
        {
          word: 'hello',
          affixes: nil
        },
        {
          word: 'try',
          affixes: 'B'
        },
        {
          word: 'work',
          affixes: 'AB'
        }
      ],
      forbidden_words: []
    }
  end

  let(:reference_personal_dic_result) do
    {
      approx_word_count: nil,
      words:
      [
        {
          word: 'foo',
          affixes: nil
        },
        {
          word: 'Foo',
          affixes: 'Simpson'
        }
      ],
      forbidden_words: ['bar']
    }
  end

  let(:reference_reader_result) { reference_aff_result.merge(reference_dic_result) }
end
