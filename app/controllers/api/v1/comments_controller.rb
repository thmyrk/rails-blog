module Api
  module V1
    class CommentsController < ApiController
      def create
        comment = Comments::UseCases::Create.new(create_params).call
        render :created, json: Comments::Presenter.new(comment).build(:all_fields)
      end

      def show
        comment = RepositoryRegistry.for(:comments).find(params[:id])
        render status: :ok, json: Comments::Presenter.new(comment).build(:all_fields)
      end

      def destroy
        Comments::UseCases::Destroy.new(destroy_params).call
        render status: :no_content
      end

      def update
        comment = Comments::UseCases::Update.new(update_params).call
        render status: :ok, json: Comments::Presenter.new(comment).build(:all_fields)
      end

      private

      def create_params
        params.permit(:post_id, :content, :commentable_id, :commentable_type)
      end

      def destroy_params
        params.permit(:id)
      end

      def update_params
        params.permit(:id, :post_id, :content, :commentable_id, :commentable_type)
      end
    end
  end
end
