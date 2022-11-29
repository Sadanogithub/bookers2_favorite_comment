class BooksController < ApplicationController
  def create
    @books = Book.all
    @book = Book.new(book_params)
    @book.user_id = current_user.id
     @users = User.all
    if @book.save
      flash[:message] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      render :index
    end
  end

  def index
    @book = Book.new
    @books = Book.page(params[:page]).reverse_order
    @users = User.all
  end

  def show
    @book = Book.find(params[:id])
    
    @book_comment = BookComment.new
    
  end

  def edit
  @book = Book.find(params[:id])
    if @book.user.id != current_user.id
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])

    if  @book.update(book_params)
      flash[:message] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
