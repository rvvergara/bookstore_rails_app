class V1::UsersController < ApplicationController
  before_action :pundit_user, only: %i[update show index]

  def index
    page = params[:page] || '1'
    @users = User.paginated(page)
    @count = User.count
    render :users, status: :ok
  end

  def show
    @user = User.find_by_username(params[:username])
    if @user
      render :user, locals: { token: nil}, status: :ok
    else
      render_error(nil, 'Cannot find user', 404)
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      token = JsonWebToken.encode(user_data(@user))
      render :user, locals: { token: token }, status: :created
    else
      render_error(@user, 'Cannot create account', :unprocessable_entity)
    end
  end

  def update
    @user = User.find_by(id: params[:id]) || User.find_by(username: params[:username])
    authorize @user
    if @user.update(permitted_attributes(@user)) &&
       permitted_attributes(@user) != {}
      @user.reload
      token = permitted_attributes(@user)[:access_level] ? nil : JsonWebToken.encode(user_data(@user))
      render :user, locals: { token: token}, status: :accepted
    elsif permitted_attributes(@user) == {}
      render_error(nil, 'You can only change access level', :unauthorized)
    else
      render_error(@user, 'Cannot update account', :unprocessable_entity)
    end
  end

  private

  def user_params
    params.require(:user)
          .permit(:username,
                  :email,
                  :password,
                  :password_confirmation,
                  :first_name,
                  :last_name,
                  :access_level)
  end

  def admin_allowed_change(user)
    if @current_user != user && user_params.keys[0] != 'access_level'
      render_error(nil, 'You can only change access level', :unauthorized)
    end
  end
end
