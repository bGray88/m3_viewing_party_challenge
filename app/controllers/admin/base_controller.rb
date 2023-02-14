class Admin::BaseController < ApplicationController
  before_action :require_admin

  private

  def require_admin
    unless current_admin?
      flash[:error] = "Not authorized to access requested"
      redirect_to root_path
    end
  end
end
