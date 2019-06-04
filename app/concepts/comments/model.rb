module Comments
  class Model < ApplicationRecord
    self.table_name = "comments"

    belongs_to :post, class_name: "Posts::Model"
    belongs_to :commentable, class_name: "Comments::Model", polymorphic: true

    has_many :comments, class_name: "Comments::Model", as: :commentable
  end
end
