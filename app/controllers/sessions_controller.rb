class SessionsController < ApplicationController

  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(name: params[:user][:name])
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_back_or_default(items_path)
    else
      @user = User.new
      flash.now[:danger] = "Login unsuccessful. Please try again"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    session[:return_to] = nil
    flash[:info] = "You have successfully logged out."
    redirect_to root_path
  end


end
