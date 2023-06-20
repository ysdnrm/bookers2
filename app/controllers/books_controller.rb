class BooksController < ApplicationController

  def index
   @book = Book.new
   @books = Book.all
   @user = current_user
  end

  def create
    @book = Book.new(book_params)
    # current_user は、ログイン中のユーザーの情報を取得できる便利な記述(devise を導入しないと使用することができない)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
    # idが必要だった
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      @user = User.find_by(params[:id])
      render :index
    end  
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
  end
#  User.find_by(params[:id])
  def edit
    is_matching_book_user
    @book = Book.find(params[:id])
  end

  def update
    is_matching_book_user
     @book = Book.find(params[:id])
     # 更新内容（book_params）が入っているのが@book
     # バリデーションの実装は流れが大事
     if @book.update(book_params)
       flash[:notice] = "You have updated book successfully."
       redirect_to book_path(@book.id)
     else
      # createとは違い、変数の再定義はいらない
      render :edit
     end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end


  # 投稿データのストロングパラメータ
  private
  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end
  
  def is_matching_book_user
    book = Book.find(params[:id])
    unless book.user.id == current_user.id
      redirect_to books_path
    end
  end
  
end
