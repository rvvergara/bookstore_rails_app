class V1::BooksController < ApplicationController
  before_action :pundit_user
  def index
    @books = Book.all

    render :books,status: :ok
  end

  def show
    @book = Book.find(params[:id]).data_hash_for_user(@current_user)

    render :book, status: :ok
  end

  def create
    @book = Book.new(book_params)
    authorize @book
    if @book.save
      render :book, status: :ok
    else
      render_error(@book, 'Cannot save book', :unprocessable_entity)
    end
  end

  private

  def book_params
    params.require(:book).permit(
      :title,
      :subtitle,
      :authors,
      :description,
      :published_date,
      :thumbnail,
      :isbn,
      :page_count,
      :category
    )
  end
end
