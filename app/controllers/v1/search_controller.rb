class V1::SearchController < ApplicationController
  def book_search
    @books = Book.search_by_term(params[:q])

    render :books, status: :ok
  end
end
