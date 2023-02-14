class Manager::UsersController < ApplicationController
  before_action :find_user, only: [:show]
  before_action :validate_role, only: [:show]

  def new
    @user = User.new
  end

  def show; end

  private

  def validate_role
    unless current_manager?
      flash[:error] = "Not authorized to access requested"
      redirect_to root_path
    end
  end

  def find_user
    @user = current_user
  end
end
