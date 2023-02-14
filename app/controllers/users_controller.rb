class UsersController < ApplicationController
  before_action :format_email, only: [:create]
  before_action :find_user, only: [:show]

  def new
    @user = User.new
  end

  def show; end

  def login_form; end

  def login_user
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      flash[:success] = "Welcome, #{user.name}!"
      session[:user_id] = user.id
      redirect_to admin_dashboard_path and return if current_admin?
      redirect_to manager_dashboard_path and return if current_manager?
      redirect_to user_path(user)
    else
      flash[:error] = "Sorry, your credentials are bad"
      render :new
    end
  end

  def create
    user = User.create(user_params)
    if user.save
      flash[:success] = "Welcome, #{user.name}!"
      redirect_to user_path(user)
    else
      flash[:error] = user.errors.full_messages.to_sentence
      redirect_to register_path
    end
  end

  private

  def format_email
    params[:email]&.downcase!
  end

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
