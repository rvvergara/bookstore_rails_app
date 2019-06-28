class V1::UsersController < ApplicationController
  def create
    @user = User.new(user_params)

    if @user.save
      token = JsonWebToken.encode(user_data(@user))
      render :create, locals: { token: token },status: :created
    else
      render_error(@user, "Cannot save user", :unprocessable_entity)
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :first_name, :last_name)
  end
end
