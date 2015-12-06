class Api::UsersController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
    @user = User.new(create_params)
    unless @user.save
      @error_message = @user.errors.full_messages
    end
  end

  def show
    @user = User.find(user_params[:id])
  end

  private
  def user_params
    params.permit(:id)
  end


  def create_params
    params.permit(:email, :name, :password, :password_confirmation, :sex)
  end

end
