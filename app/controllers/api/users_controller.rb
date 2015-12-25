class Api::UsersController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
    @user = User.new(user_params)
    if @user.save
      @lover = @user.meet_your_soul_mate
    else
      @error_message = @user.errors.full_messages
    end
  end

  def show
    @user = User.find(params[:id])
    @lovers = @user.following
    @longest_periods = @user.longest_periods
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
  end

  def check_lover
    user = User.find(params[:id])
    user.check_lover(params[:lover_id])
  end

  private
  def user_params
    params.permit(:email, :name, :password, :password_confirmation, :sex, :avatar)
  end

end
