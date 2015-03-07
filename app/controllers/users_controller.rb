class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "Your account was created successfully."
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render :new
    end
  end

  def edit; end

  def show; end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end
end