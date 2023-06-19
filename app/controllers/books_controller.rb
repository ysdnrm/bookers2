class BooksController < ApplicationController
  
  def index
   @book = Book.new
   @books = Book.all
  end 

  def create
    @book = Book.new(book_params)
    # current_user は、ログイン中のユーザーの情報を取得できる便利な記述(devise を導入しないと使用することができない)
    @book.user_id = current_user.id
    @book.save
    # idが必要だった
      redirect_to book_path(@book.id)
  end

  def show
    @book = Book.find(params[:id])
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end


  # 投稿データのストロングパラメータ
  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
  
end
