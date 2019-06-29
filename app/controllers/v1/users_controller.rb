class V1::UsersController < ApplicationController
  before_action :authenticate!, only: :update
  before_action only: [:update] do
    allow_correct_user(User.find(params[:id]))
  end

  def create
    @user = User.new(user_params)

    if @user.save
      token = JsonWebToken.encode(user_data(@user))
      render :create, locals: { token: token },status: :created
    else
      render_error(@user, "Cannot save user", :unprocessable_entity)
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      render json: {
        message: "Account updated",
        data: @user
      }, status: :accepted
    else
      render_error(@user, "Cannot update account", :unprocessable_entity)
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :first_name, :last_name, :access_level)
  end
end
