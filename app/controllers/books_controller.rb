class BooksController < ApplicationController

  before_action :authenticate_user!

  def show
    @book = Book.new
    @savebook = Book.find(params[:id])
    #カンニングコード
    @user = User.find(@savebook.user_id)
  end

  def index
    @book = Book.new
    @user = current_user
    @books = Book.all
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book)
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
    correct_book(@book)
  end

  def update
    @book = Book.find(params[:id])
    # @user = User.find(@book.user)
    if @book.update(book_params)
      flash[:notice] = "Book was successfully updated."
      redirect_to book_path(@book)
    else
      render :edit
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

  def correct_book(book)
    if current_user.id != book.user.id
      redirect_to books_path
    end
  end

end
