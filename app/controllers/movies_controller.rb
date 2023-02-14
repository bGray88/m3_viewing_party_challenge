class MoviesController < ApplicationController
  before_action :find_user_and_movies, only: [:index]
  before_action :find_user_and_movie, only: [:show]

  def index; end

  def show; end

  private

  def find_user_and_movies
    @user = User.find(params[:id])
    @movies = Movie.all
  end

  def find_user_and_movie
    @user = User.find(params[:user_id])
    @movie = Movie.find(params[:id])
  end
end
