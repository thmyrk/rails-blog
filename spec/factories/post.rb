FactoryBot.define do
  factory :post do
    sequence(:title) { |i| "Post title #{i}" }
    sequence(:content) { |i| "Post content #{i}" }
  end
end
