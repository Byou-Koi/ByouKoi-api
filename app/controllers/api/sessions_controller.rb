class Api::SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def create
    @user = login(params[:email], params[:password])
    unless @user
      @error_message = ["メールアドレスかパスワードが間違っています。"]
    end
  end
end
