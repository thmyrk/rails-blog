FactoryBot.define do
  factory :post, class: Posts::Model do
    sequence(:title) { |i| "Post title #{i}" }
    sequence(:content) { |i| "Post content #{i}" }

    initialize_with do
      RepositoryRegistry.for(:posts).insert!(attributes)
    end
  end
end
