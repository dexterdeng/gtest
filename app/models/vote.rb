class Vote < ApplicationRecord

  belongs_to :user
  belongs_to :votable, polymorphic: true


  after_create :refresh_votes_count
  after_destroy :refresh_votes_count

  private

  def refresh_votes_count
    self.votable.update_column :votes_count, self.votable.votes.count if self.votable.respond_to? :votes_count
  end
end
