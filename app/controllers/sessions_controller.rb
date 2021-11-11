class SessionsController < ApplicationController
  before_action :logged_in_redirect, only: [:new, :create]
  before_action :find_user, only: [:create]

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(username: login_params[:username])
    if @user && @user.authenticate(login_params[:password])
      session[:user_id] = @user.id
      flash[:success] = "Welcome Back #{@user.username}!"
      redirect_to root_path
    else
      @user = User.new
      flash[:alert] = "Invalid username or password! Please try again!"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Signed out!"
    
    redirect_to login_path
  end

  private

  def find_user
    @user = User.find_by(username: login_params[:username])
  end

  def login_params
    params.require(:session).permit(:username, :password)
  end

  def logged_in_redirect
    if logged_in?
      flash[:alert] = "You are already logged in!"
      redirect_to root_path
    end
  end
end
