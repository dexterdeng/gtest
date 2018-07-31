class VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_votable


  def toggle
    @error_msg =  '点赞参数'  and return unless @votable
    @error_msg =  '不能给自己点赞' and return if current_user.id == @votable.user_id

    vote = @votable.votes.find_by_user_id(current_user.id)
    vote ? vote.destroy : @votable.votes.create(user_id: current_user.id)
  end


  private

  def find_votable
    klass = params[:votable_type] ? params[:votable_type].constantize : nil
    @votable ||= klass.find_by_id(params[:votable_id]) if klass && params[:votable_id]
  end

end
