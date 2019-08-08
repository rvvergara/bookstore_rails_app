class V1::SearchController < ApplicationController
  before_action :pundit_user

  def book_search
    page = params[:page] || '1'
    @books = Book.user_book_search(@current_user, params[:q], page)
    @count = Book.search_by_term(params[:q]).count
    render :books, status: :ok
  end

  def check_in_library
    @in_library = Book.exists?(isbn: params[:isbn])

    render :in_library, status: :ok
  end
end
