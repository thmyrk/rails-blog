module Api
  module V1
    class CommentsController < ApiController
      def create
        comment = Comments::UseCases::Create.new(comment_params).call
        render :created, json: Comments::Presenter.new(comment).build(:all_fields)
      end

      private

      def comment_params
        params.permit(:post_id, :content, :commentable_id, :commentable_type)
      end
    end
  end
end
