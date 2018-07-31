class AddCommentsCountToCommentable < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :comments_count, :integer, :default => 0
    add_column :posts, :comments_count, :integer, :default => 0
    add_index  :articles, :comments_count
    add_index  :posts, :comments_count
  end
end
