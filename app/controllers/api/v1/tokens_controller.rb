class Api::V1::TokensController < ApplicationController

  def create
    user = User.find_by_email params[:email]
    if user&.authenticate(params[:password])
      render json: {
        token: JsonWebToken.encode(user_id: user.id),
        user: user
      }
    else
      render json: {
        token: nil,
        user: User.new
      }, status: :unauthorized
    end
  end

end
