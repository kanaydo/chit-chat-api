class Api::V1::UserSessionsController < ApplicationController

  def create
    @user = User.find_by_credential(params[:credential])
    if @user&.authenticate(params[:password])
      user = UserBlueprint.render(@user)
      render json: user, status: :ok
    else
      render json: { message: "Invalid username or password, please try again!" }, status: :unauthorized
    end
  end

end
