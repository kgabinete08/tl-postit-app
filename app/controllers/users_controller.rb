class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]
  before_action :require_correct_user, only: [:edit, :update]

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

  def update
    if @user.update(user_params)
      flash[:notice] = "Your account has been updated."
      redirect_to root_path
    else
      render :edit
    end
  end

  def show; end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :time_zone)
  end

  def set_user
    @user = User.find_by slug: params[:id]
  end

  def require_correct_user
    redirect_to root_path if @user != current_user
  end
end