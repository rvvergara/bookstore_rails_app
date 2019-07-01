class V1::UsersController < ApplicationController
  before_action :authenticate!, only: [:update, :show]
  before_action only: [:update] do
    allow_correct_user(User.find_by_username(params[:username]))
  end

  def show
    @user = User.find_by_username(params[:username])
    if @user
      render :user, locals: { token: nil}, status: :ok
    else
      render_error(nil, "Cannot find user", 404)
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      token = JsonWebToken.encode(user_data(@user))
      render :user, locals: { token: token },status: :created
    else
      render_error(@user, "Cannot save user", :unprocessable_entity)
    end
  end

  def update
    @user = User.find_by_username(params[:username])
    token = request.headers['Authorization'].split(' ').last
    if @user.update(user_params)
      render :user, locals: { token: token}, status: :accepted
    else
      render_error(@user, "Cannot update account", :unprocessable_entity)
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :first_name, :last_name, :access_level)
  end
end
