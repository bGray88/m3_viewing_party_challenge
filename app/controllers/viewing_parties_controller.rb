class ViewingPartiesController < ApplicationController
  before_action :validate_user, only: [:new]

  def new; end

  private

  def validate_user
    unless current_user
      flash[:error] = "Login necessary"
      redirect_to movie_path(params[:movie_id])
    end
  end
end
