class Api::V1::UsersController < ApplicationController

  before_action :set_user, only: [:show, :update, :destroy, :contacts, :add_to_contact]

  def show
    user = UserBlueprint.render(@user)
    render json: user, status: :ok
  end

  def create
    @user = User.new user_params
    if @user.save
      user = UserBlueprint.render(@user)
      render json: user, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update user_params
      user = UserBlueprint.render(@user)
      render json: user, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity

    end
  end

  def destroy
    if @user.destroy
      head :no_content
    else
      render json: @user.errors, status: :not_modified
    end
  end

  def contacts
    contacts = ContactBlueprint.render(@user.contact_list, view: :normal)
    render json: contacts, status: :ok
  end

  def add_to_contact
    @contact = @user.contacts.new(friend_id: params[:friend_id])
    if @contact.save
			contact = ContactBlueprint.render(@contact, view: :normal)
      render json: contact, status: :created
    else
      render json: contacterrors, status: :unprocessable_entity
    end
  end

  def search
    @users = User.search(params[:keyword])
    users = UserBlueprint.render(@users)
    render json: users, status: :ok
  end

  def check_contact
    result = Contact.check_contact(params[:user_id], params[:id])
    render json: { status: result }, status: :ok
  end

  private
  # handle user params
  def user_params
    params.require(:user).permit(
      :name,
      :username,
      :email,
      :password,
      :avatar
    )
  end

  def set_user
    @user = User.find params[:id]
  end

end
