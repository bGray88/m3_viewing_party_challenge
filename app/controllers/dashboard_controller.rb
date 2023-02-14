class DashboardController < ApplicationController
  before_action :validate_user, only: [:index]

  def index; end

  private

  def validate_user
    unless current_user
      flash[:error] = "Login necessary"
      redirect_to root_path
    end
  end
end
