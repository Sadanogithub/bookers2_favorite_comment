class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show

    @user = User.find(params[:id])
    @books = @user.books.page(params[:page]).reverse_order
  end

  def edit
    @user = User.find(params[:id])
    if @user.id != current_user.id
      redirect_to user_path(current_user.id)
    end
  end

  def create
    @user = User.find(params[:id])
    @books = @user.books.page(params[:page]).reverse_order
    @book = Book.new(book_params)
    flash[:messge] = "You have created book successfully."
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id)
    else
      render :index
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    flash[:messge] = "You have updated user successfully."

    if  @user.update(user_params)
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name,  :profile_image, :introduction)
  end
  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
