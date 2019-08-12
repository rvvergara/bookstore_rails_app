class V1::BooksController < ApplicationController
  before_action :pundit_user
  def index
    page = params[:page] || '1'
    @books = Book.paginated(page, @current_user)
    @count = Book.count
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
      @book = @book.data_hash_for_user(@current_user)
      render :book, status: :created
    else
      render_error(@book, 'Cannot save book', :unprocessable_entity)
    end
  end

  def update
    @book = Book.find_by(id: params[:id])
    authorize @book

    if @book.update(book_params)
      @book = @book.data_hash_for_user(@current_user)
      render :book, status: :accepted
    else
      render_error(@book, 'Cannot update book', :unprocessable_entity)
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
