module Posts
  class Model < ApplicationRecord
    self.table_name = "posts"

    has_many :comments, class_name: "Comments::Model", as: :commentable
  end
end
