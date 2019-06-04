FactoryBot.define do
  factory :comment, class: Comments::Model do
    post
    commentable_id { post.id }
    commentable_type { "Posts::Model" }
    sequence(:content) { |i| "Comment content #{i}" }

    initialize_with do
      RepositoryRegistry.for(:comments).insert!(attributes)
    end
  end
end
