class Manager::BaseController < ApplicationController
  before_action :require_manager

  def index; end

  private

  def require_manager
    render file: "/public/404" unless current_manager?
  end
end
