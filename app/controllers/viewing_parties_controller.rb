class ViewingPartiesController < ApplicationController
  before_action :validate_user, only: [:new]

  def new; end

  private

  def validate_user
    unless session[:user_id]
      flash[:error] = "Login necessary"
      redirect_to movie_path(params[:user_id], params[:movie_id])
    end
  end
end
