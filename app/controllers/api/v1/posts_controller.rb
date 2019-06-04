module Api
  module V1
    class PostsController < ApiController
      def create
        post = Posts::UseCases::Create.new(create_params).call
        render status: :created, json: Posts::Presenter.new(post).build(:all_fields)
      end

      def show
        post = RepositoryRegistry.for(:posts).find(params[:id])
        render status: :ok, json: Posts::Presenter.new(post).build(:all_fields)
      end

      def destroy
        Posts::UseCases::Destroy.new(destroy_params).call
        render status: :no_content
      end

      def update
        post = Posts::UseCases::Update.new(update_params).call
        render status: :ok, json: Posts::Presenter.new(post).build(:all_fields)
      end

      def export_to_xlsx
        @post = RepositoryRegistry.for(:posts).find_with_comments(params[:id])

        render xlsx: "post", template: Rails.root.join("app", "concepts", "posts", "templates", "post")
      end

      private

      def create_params
        params.permit(:title, :content)
      end

      def destroy_params
        params.permit(:id)
      end

      def update_params
        params.permit(:id, :title, :content)
      end
    end
  end
end
