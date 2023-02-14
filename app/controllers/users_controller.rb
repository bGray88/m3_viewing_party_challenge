class UsersController < ApplicationController
  before_action :format_email, only: [:create]
  before_action :find_user, only: [:show]
  before_action :validate_user, only: [:show]

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
      redirect_to admin_user_path and return if current_admin?
      redirect_to manager_user_path and return if current_manager?
      redirect_to user_path
    else
      flash[:error] = "Sorry, your credentials are bad"
      render :new
    end
  end

  def logout_user
    @_current_user = session[:user_id] = nil
    flash[:success] = "Thanks for stopping by!"
    redirect_to login_path
  end

  def create
    user = User.create(user_params)
    if user.save
      flash[:success] = "Please Log In, #{user.name}"
      redirect_to login_path
    else
      flash[:error] = user.errors.full_messages.to_sentence
      redirect_to register_path
    end
  end

  private

  def validate_user
    unless current_user
      flash[:error] = "Login necessary"
      redirect_to root_path
    end
  end

  def format_email
    params[:email]&.downcase!
  end

  def find_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
