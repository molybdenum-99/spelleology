module Validation
  def validate_input(input)
    validation = self.class::Schema.call(input)

    validation.success? ? Success(input) : Failure(validation.messages)
  end
end
