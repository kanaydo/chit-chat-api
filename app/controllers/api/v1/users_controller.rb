class Api::V1::UsersController < ApplicationController

  def show
    user = User.find params[:id]
    render json: user, status: :ok
  end
  
  def create
    user = User.new user_params
    if user.save
      render json: user, status: :created
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def update
    user = User.find params[:id]
    if user.update user_params
      render json: user, status: :ok
    else
      render json: user.errors, status: :not_modified 
    end
  end

  def destroy
    user = User.find params[:id]
    if user.destroy
      render json: user, status: :no_content
    else
      render json: user.errors, status: :not_modified
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

end
