class UsersController < ApplicationController
  before_action :require_login, only: [:show]
  before_action :require_admin, only: [:index]
  before_action :current_user_or_admin, only: [:edit, :update, :destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      session[:user_id] = @user.id
      redirect_to items_path
    else
      @user.errors.full_messages.each do |error|
        flash.now[error] = error
      end
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.update(params[:id],user_params)
    if @user.valid?
      redirect_to user_path(@user)
    else
      render :edit
    end
    #may want to redirect_to index page instead (where all products are)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :admin)
  end

  def current_user_or_admin
    unless current_user == User.find(params[:id]) || current_user.try(:admin)
      flash[:danger] = "You do not have permission to perform that action."
      redirect_to root_path
    end
  end

end
