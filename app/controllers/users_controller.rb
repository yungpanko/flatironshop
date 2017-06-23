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
    @user = User.new(user_params)
    # respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        UserMailer.welcome_email(@user).deliver_now
        redirect_to items_path
      else
        flash.now[:danger] = []
        @user.errors.full_messages.each do |error|
          flash.now[:danger] << error
        end
        render :new
      end
  end

  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.update(params[:id],user_params)
    if @user.valid?
      redirect_to user_path(@user)
    else
      flash.now[:danger] = []
      @user.errors.full_messages.each do |error|
        flash.now[:danger] << error
      end
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :admin, :bio, :avatar)
  end

  def current_user_or_admin
    unless current_user == User.find(params[:id]) || current_user.try(:admin)
      flash[:danger] = "You do not have permission to perform that action."
      redirect_to root_path
    end
  end

end
