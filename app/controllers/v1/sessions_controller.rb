class V1::SessionsController < ApplicationController
  def create
    @user = User.find_by(email: params[:email_or_username]) || User.find_by(username: params[:email_or_username])
    if @user && @user.valid_password?(params[:password])
      data = user_data(@user)
      token = JsonWebToken.encode(data)
      render :create, locals: {token: token}, status: :created
    else
      render_error(@user, "Invalid credentials", :unauthorized)
    end
  end
end
