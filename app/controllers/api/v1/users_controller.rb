class Api::V1::UsersController < ApplicationController

  before_action :set_user, only: [:show, :update, :destroy, :contacts]
  before_action :check_user, only: [:update, :destroy, :contacts] 
  before_action :set_contact_owner, only: [:add_to_contact]
  before_action :validate_owner, only: [:add_to_contact]

  # show user
  def show
    user = @user.attributes.merge(avatar: @user.avatar.url(:medium))
    render json: user, status: :ok
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
      user = @user.attributes.merge(avatar: @user.avatar.url(:medium))
      render json: user, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity 

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

  def contacts
    contacts = @user.contact_list
    render json: contacts, status: :ok
  end

  def add_to_contact
    contact = @owner.contacts.new(friend_id: params[:id])
    if contact.save
      render json: contact, status: :created
    else
      render json: contact.errors, status: :unprocessable_entity
    end
  end

  def search
    term = params[:keyword]
    if term
      users = User.search(params[:keyword])
    else
    end
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

  #handle contact params
  def contact_params
    params.require(:contact).permit(
      :user_id
    )
  end

  def set_contact_owner
    @owner = User.find contact_params[:user_id]
  end

  # set current user to specific action
  def set_user
    @user = User.find params[:id]
  end

  # validate user before run some action
  def check_user
    head :forbidden unless @user.id == current_user&.id
  end
  
  def validate_owner
    head :forbidden unless @owner.id == current_user&.id
  end


end
