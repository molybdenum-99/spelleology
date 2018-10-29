# frozen_string_literal: true

require 'ostruct'

class Dictionary < OpenStruct
  def initialize(aff, dic)
    OpenStruct.new(aff.merge(dic))
  end
end
