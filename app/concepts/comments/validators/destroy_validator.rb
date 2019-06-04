module Comments
  module Validators
    class DestroyValidator
      def self.call(params)
        schema.call(params)
      end

      def self.schema
        Dry::Validation.Schema(BaseValidator) do
          required(:id).filled(:str?)
        end
      end
    end
  end
end
