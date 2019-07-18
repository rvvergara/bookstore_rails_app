class V1::CollectionItemsController < ApplicationController
  before_action :pundit_user

  def index
    @user = User.find_by(username: params[:user_username])
    @collection = @user.collection

    render json: @collection, status: :ok
  end
end
