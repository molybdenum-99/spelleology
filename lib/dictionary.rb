class Dictionary
  def initialize(approx_word_count:, words:, forbidden_words:, affixes:)
    @approx_word_count = approx_word_count
    @words = words
    @forbidden_words = forbidden_words
    @affixes = affixes
  end
end
