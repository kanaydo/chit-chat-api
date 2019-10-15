class Api::V1::UsersController < ApplicationController

  before_action :set_user, only: [:show, :update, :destroy]
  before_action :check_user, only: [:update, :destroy]

  # show user
  def show
    render json: @user, status: :ok
  end
  
  # create new user
  def create
    user = User.new user_params
    if user.save
      render json: user, status: :created
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  # update user information
  def update
    if @user.update user_params
      render json: @user, status: :ok
    else
      render json: @user.errors, status: :not_modified 
    end
  end

  # delete user
  def destroy
    if @user.destroy
      head :no_content
    else
      render json: @user.errors, status: :not_modified
    end
  end


  private
  def user_params
    params.require(:user).permit(
      :name,
      :username,
      :email,
      :password
    )
  end

  # set current user to specific action
  def set_user
    @user = User.find params[:id]
  end

  # validate user before run some action
  def check_user
    head :forbidden unless @user.id == current_user&.id
  end

end
