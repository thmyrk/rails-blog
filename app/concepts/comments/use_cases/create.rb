module Comments
  module UseCases
    class Create < BaseUseCase
      def call
        validate_params!
        params["commentable_type"] = case params["commentable_type"]
                                     when "post"
                                       Posts::Model
                                     when "comment"
                                       Comments::Model
                                     end

        RepositoryRegistry.for(:comments).insert!(params)
      end

      private

      def validation_schema
        Comments::Validators::CreateValidator
      end
    end
  end
end
