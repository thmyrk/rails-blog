module Comments
  module Validators
    class UpdateValidator
      def self.call(params)
        schema.call(params)
      end

      def self.schema
        Dry::Validation.Schema(BaseValidator) do
          optional(:post_id).filled(:str?)
          optional(:content).filled(:str?)
          optional(:commentable_id).filled(:str?)
          optional(:commentable_type).filled(:str?)
        end
      end
    end
  end
end
