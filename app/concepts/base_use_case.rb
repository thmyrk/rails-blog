class BaseUseCase
  attr_reader :params

  class ParamValidationError < StandardError; end

  def initialize(params)
    @params = params
  end

  def validate_params!
    schema = validation_schema.call(params)
    raise ParamValidationError, "Param validation failed: #{schema.messages}" if schema.failure?
  end

  def validation_schema
    raise NotImplementedError
  end
end
