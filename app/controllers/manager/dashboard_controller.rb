class Manager::DashboardController < Manager::BaseController
  def index
    @users = User.all
  end
end
