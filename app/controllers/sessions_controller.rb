class SessionsController < ApplicationController
  before_action :require_login, only: [:show]

  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(name: params[:user][:name])
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to user_path(@user)
      #may want to redirect_to index page instead (where all products are)
    else
      @user = User.new
      flash.now[:error] = "Login unsuccessful. Please try again"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "You have successfully logged out."
  end


end
