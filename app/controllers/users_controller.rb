class UsersController < ApplicationController
  before_action :require_login, only: [:show]

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
    @reviews = current_user.reviews
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user = User.update(user_params)
    # byebug
    redirect_to user_path(@user)
    #may want to redirect_to index page instead (where all products are)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :admin, :bio)
  end

end
