class V1::CollectionItemsController < ApplicationController
  before_action :pundit_user
  before_action :set_user, except: :create

  def index
    @collection = @user.collection
    render :index, status: :ok
  end

  def create
    @item = @current_user.items.build(item_params)
    if @item.save
      render :item, status: :created
    else
      render_error(@item, 'Cannot add book to collection', :unprocessable_entity)
    end
  end

  def update
    @item = @user.items.find(params[:id])
    authorize(@item)
    if @item.update(item_params)
      render :item, status: :accepted
    else
      render_error(@item, 'Cannot update page count', :unprocessable_entity)
    end
  end

  def destroy
    @item = @user.items.find(params[:id])
    authorize(@item)
    @item.destroy
  end

  private

  def set_user
    @user = User.find_by(username: params[:user_username])
  end

  def item_params
    params.require(:collection_item).permit(:book_id, :user_id, :current_page)
  end
end
