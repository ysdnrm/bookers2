class BooksController < ApplicationController
  def new
    @book = Book.new
  end
  
  def create
    @book = Book.new(book_params)
    # current_user は、ログイン中のユーザーの情報を取得できる便利な記述(devise を導入しないと使用することができない)
    @book.user_id = current_user.id
   if @book.save
      redirect_to books_path
   else
      render :new
   end  
  end

  def index
    # 1ページ分の決められた数のデータだけを、新しい順に取得するように変更
    @books = Book.page(params[:page])
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
