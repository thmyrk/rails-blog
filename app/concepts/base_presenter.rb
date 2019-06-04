class BasePresenter
  attr_reader :object

  def initialize(object)
    @object = object
  end

  def build(*object_fields)
    result = {}

    object_fields.each do |object_field|
      result.merge!(send(object_field))
    end

    result
  end
end
