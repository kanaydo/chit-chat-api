class Api::V1::UsersController < ApplicationController
  def index
    users = User.all
    response = {
      message: 'hai',
      users: users
    }
    render json: response, status: :ok
  end
end
