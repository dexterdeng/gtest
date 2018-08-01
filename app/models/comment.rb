class Comment < ApplicationRecord

  attr_accessor :row_number #用于复杂查询临时存值

  belongs_to :user
  belongs_to :commentable, polymorphic: true

  has_many   :votes, as: :votable

  after_create :refresh_comments_count
  after_destroy :refresh_comments_count

  private

  def refresh_comments_count
    self.commentable.update_column :comments_count, self.commentable.comments.count if self.commentable.respond_to? :comments_count
  end

end
