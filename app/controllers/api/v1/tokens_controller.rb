class Api::V1::TokensController < ApplicationController

  def create
    user = User.find_by_email params[:email]
    if user&.authenticate(params[:password])
      render json: {
        status: true,
        user: user
      }, status: :ok
    else
      render json: {
        message: "Invalid username or password, please try again!"
      }, status: :unauthorized
    end
  end

end
