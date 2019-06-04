module Comments
  module UseCases
    class Update < BaseUseCase
      def call
        validate_params!
        comment = RepositoryRegistry.for(:comments).find(params[:id])
        RepositoryRegistry.for(:comments).update!(comment, params)
        comment
      end

      private

      def validation_schema
        Comments::Validators::UpdateValidator
      end
    end
  end
end
