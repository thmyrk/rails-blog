module Posts
  module UseCases
    class Destroy < BaseUseCase
      def call
        validate_params!
        post = RepositoryRegistry.for(:posts).find(params[:id])
        RepositoryRegistry.for(:posts).destroy!(post)
      end

      private

      def validation_schema
        Posts::Validators::DestroyValidator
      end
    end
  end
end
