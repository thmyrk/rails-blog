module Posts
  module UseCases
    class Update < BaseUseCase
      def call
        validate_params!
        post = RepositoryRegistry.for(:posts).find(params[:id])
        RepositoryRegistry.for(:posts).update!(post, params)
        post
      end

      private

      def validation_schema
        Posts::Validators::UpdateValidator
      end
    end
  end
end
