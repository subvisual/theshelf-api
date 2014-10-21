class BooksController < ApplicationController
  before_action :authorize

  def index
    @books = Book.all.decorate
  end

  def show
    @book = book.decorate
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      flash[:success] = t('flash.book.created')
      redirect_to book_path(@book)
    else
      render :new
    end
  end

  def edit
    @book = book.decorate
  end

  def update
    if book.update(book_params)
      flash[:success] = t('flash.book.updated')
      redirect_to book_path(@book)
    else
      render :edit
    end
  end

  def destroy
    book.destroy
    flash[:success] = t('flash.book.deleted')
    redirect_to books_path
  end

  private

  def book
    @_book ||= Book.includes({reviews: :reviewer}).find(params[:id])
  end

  def book_params
    params.require(:book).permit(:authors, :owner, :pages, :published_on, :subtitle, :summary, :title, :url, :cover, :cover_cache, :isbn, :ebook)
  end
end
