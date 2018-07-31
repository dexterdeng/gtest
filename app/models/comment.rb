class Comment < ApplicationRecord

  belongs_to :user
  belongs_to :commentable, polymorphic: true

  after_create :refresh_comments_count
  after_destroy :refresh_comments_count

  private

  def refresh_comments_count
    self.commentable.update_column :comments_count, self.commentable.comments.count if self.commentable.respond_to? :comments_count
  end

end
