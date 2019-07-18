class V1::CollectionItemsController < ApplicationController
  # before_action :pundit_user

  def index
    @user = User.find_by(username: params[:user_username])
    @collection = @user.collection
    render :index, status: :ok
  end

  def create
    @item = @current_user.items.build(item_params)

    if @item.save
      render :item, status: :created
    else
      render_error(@item, "Cannot add book to collection", :unprocessable_entity)
    end
  end

  private

  def item_params
    params.require(:collection_item).permit(:book_id, :user_id, :current_page)
  end
end
