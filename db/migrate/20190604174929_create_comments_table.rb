class CreateCommentsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.references :post, null: false
      t.string :content, null: false
      t.integer :commentable_id, null: false
      t.string :commentable_type, null: false
    end

    add_foreign_key :comments, :posts
  end
end
