class BooksController < ApplicationController
  before_action :authenticate_user!
  

  def index
    @book = Book.new
    @books = Book.all.order(created_at: :asc)
  end

  def show
    @book = Book.new
    @book_show = Book.find(params[:id])
  end

  def create
    @book = Book.new(book_params)
    @book.user = current_user
    if @book.save
      redirect_to book_path(@book), notice: "You have creatad book successfully."
    else
      @books = Book.all.order(created_at: :asc)
      render action: :index
    end
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user_id != current_user.id
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id), notice: "You have updated book successfully."
    else
      render action: :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

  def ensure_correct_user
    @book = Book.find_by(id: params[:id])
    if @book.user_id != current_user.id
      redirect_to books_path
    end
  end
end
