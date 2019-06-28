class V1::UsersController < ApplicationController
  def create
    @user = User.new(user_params)

    if @user.save
      token = JsonWebToken.encode({
        id: @user.id,
        username: @user.username,
        email: @user.email,
        first_name: @user.first_name,
        last_name: @user.last_name,
      })
      render :create, locals: { token: token },status: :created
    else
      render json: {
        error: "Cannot save user",
        data: @user.errors
      }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :first_name, :last_name)
  end
end
