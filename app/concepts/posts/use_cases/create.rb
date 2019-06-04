module Posts
  module UseCases
    class Create < BaseUseCase
      def call
        validate_params!
        RepositoryRegistry.for(:posts).insert!(params)
      end

      private

      def validation_schema
        Posts::Validators::CreateValidator
      end
    end
  end
end
