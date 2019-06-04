module Posts
  module Validators
    class CreateValidator
      def self.call(params)
        schema.call(params)
      end

      def self.schema
        Dry::Validation.Schema(BaseValidator) do
          required(:title).filled(:str?)
          required(:content).filled(:str?)
        end
      end
    end
  end
end
