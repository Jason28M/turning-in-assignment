class BooksController < ApplicationController
  def index
    @book = Book.new
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def start
    redirect_to '/books'
  end

  def new
  	@book = Book.new
  end

  def create
  	book = Book.new(book_params)
  	book.save
    if book.save
      flash[:create] = "Book was successfully created."
      redirect_to "/books/#{book.id}"
    else
      flash[:blank] = "Error!Both Title and Body must be filled with one or more letters."
      redirect_to "/books"
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    book = Book.find(params[:id])
    book.update(book_params)
    if book.update(book_params)
      flash[:notice] = "Book was successfully updated."
      redirect_to "/books/#{book.id}"
    else
      flash[:edit_blank] = "Error! Both Title and Body must be filled with one or more letters."
      redirect_to "/books/#{book.id}/edit"
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    if book.destroy
      flash[:destroy] = "Book was successfully destroyed."
     redirect_to books_path
   end
  end

  private
  def book_params
  	params.require(:book).permit(:title, :body)
  end
end
