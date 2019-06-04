module Api
  module V1
    class PostsController < ApiController
      def create
        post = Posts::UseCases::Create.new(post_params).call
        render :created, json: Posts::Presenter.new(post).build(:all_fields)
      end

      private

      def post_params
        params.permit(:title, :content)
      end
    end
  end
end
