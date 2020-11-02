class UsersController < ApplicationController

  before_action :authenticate_user!

  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = @user.books
  end

  def index
    @book = Book.new
    @user = User.find(current_user.id)
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
    correct_user(@user)
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "User was successfully updated."
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :introduction, :profile_image)
    end
    
    def correct_user(user)
      if current_user.id != user.id
        redirect_to user_path(current_user)
      end
    end
end
