class V2::SearchController < ApplicationController
  before_action :pundit_user

  def book_search
    @books = Book.user_book_search(@current_user, params[:q])
    render :books, status: :ok
  end
end
