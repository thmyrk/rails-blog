module Comments
  module UseCases
    class Destroy < BaseUseCase
      def call
        validate_params!
        comment = RepositoryRegistry.for(:comments).find(params[:id])
        RepositoryRegistry.for(:comments).destroy!(comment)
      end

      private

      def validation_schema
        Comments::Validators::DestroyValidator
      end
    end
  end
end
