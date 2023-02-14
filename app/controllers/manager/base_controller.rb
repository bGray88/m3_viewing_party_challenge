class Manager::BaseController < ApplicationController
  before_action :require_manager

  private

  def require_manager
    unless current_manager?
      flash[:error] = "Not authorized to access requested"
      redirect_to root_path
    end
  end
end
