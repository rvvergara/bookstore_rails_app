class V1::UsersController < ApplicationController
  before_action :authenticate!, only: [:update, :show]
  before_action only: [:update] do
    allow_correct_user(User.find_by_username(params[:username])) unless @current_user.access_level > 2

    admin_allowed_change(User.find_by_username(params[:username])) unless @current_user.access_level < 3
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
      render_error(@user, "Cannot create account", :unprocessable_entity)
    end
  end

  def update
    @user = User.find_by_username(params[:username])

    if @user.update(user_params)
      @user.reload
      token = JsonWebToken.encode(user_data(@user))
      render :user, locals: { token: token}, status: :accepted
    else
      render_error(@user, "Cannot update account", :unprocessable_entity)
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :first_name, :last_name, :access_level)
  end

  def admin_allowed_change(user)
    if @current_user != user && user_params.keys[0] != "access_level"
      render_error(nil, "You can only change access level", :unauthorized)
    end
  end
end
