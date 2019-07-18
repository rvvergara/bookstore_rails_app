class V1::CollectionItemsController < ApplicationController
  before_action :pundit_user

  def index
    @user = User.find_by(username: params[:user_username])
    @items = @user.items

    render json: @items, status: :ok
  end
end
