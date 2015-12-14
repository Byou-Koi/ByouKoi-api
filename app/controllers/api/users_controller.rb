class Api::UsersController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
    @user = User.new(user_params)
    unless @user.save
      @error_message = @user.errors.full_messages
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
  end

  private
  def user_params
    params.permit(:email, :name, :password, :password_confirmation, :sex, :avatar)
  end

end
