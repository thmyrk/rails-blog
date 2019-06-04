module Comments
  module Validators
    class CreateValidator
      def self.call(params)
        schema.call(params)
      end

      def self.schema
        Dry::Validation.Schema(BaseValidator) do
          required(:post_id).filled(:str?)
          required(:content).filled(:str?)
          required(:commentable_type).value(included_in?: %w[post comment])
          required(:commentable_id).filled(:str?)
        end
      end
    end
  end
end
