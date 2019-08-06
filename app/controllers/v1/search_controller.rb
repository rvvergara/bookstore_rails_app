class V1::SearchController < ApplicationController
  before_action :pundit_user

  def book_search
    page = params[:page] || '1'
    @books = Book.user_book_search(@current_user, params[:q], page)
    render :books, status: :ok
  end
end
