module Posts
  module Validators
    class UpdateValidator
      def self.call(params)
        schema.call(params)
      end

      def self.schema
        Dry::Validation.Schema(BaseValidator) do
          optional(:title).filled(:str?)
          optional(:content).filled(:str?)
        end
      end
    end
  end
end
