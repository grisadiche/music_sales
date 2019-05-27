class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update, :destroy]
  before_action :find_users, only: [:index]

  def new
    @new_user = User.new
  end

  def create
    @new_user = User.new(safe_params)
    if @new_user.save
      redirect_to @new_user
    else
      render "new"
    end
  end

  def show
  end

  def edit
  end

  def update
    if @new_user.update(safe_params)
      redirect_to @new_user
    else
      render "edit"
    end
  end

  def destroy
    if @new_user.destroy
      find_users
      render action: "index"
    else
      render "show"
    end
  end

  def index
  end

  private

  def find_user
    @new_user = User.find(params[:id])
  end

  def safe_params
    params.require(:user).permit(:username, :password)
  end

  def find_users
    @users = User.all
  end
end
