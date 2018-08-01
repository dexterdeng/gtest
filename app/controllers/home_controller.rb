class HomeController < ApplicationController

  def index
    redirect_to articles_path and return if current_user
  end

end
