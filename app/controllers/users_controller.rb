class UsersController < ApplicationController
  before_action :require_login, only: [:show]

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    session[:user_id] = @user.id
    redirect_to user_path(@user)
    #may want to redirect_to index page instead (where all products are)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.update(params[:id],user_params)
    redirect_to user_path(@user)
    #may want to redirect_to index page instead (where all products are)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :admin)
  end

end
