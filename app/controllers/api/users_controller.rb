class Api::UsersController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
    @user = User.new(create_params)
    unless @user.save
      @error_message = @user.errors.full_messages
    end
  end

  private
  def create_params
    params.permit(:email, :name, :password, :password_confirmation)
  end

end
