class BooksController < ApplicationController
  decorates_assigned :book

  def index
    @books = Book.all.decorate
  end

  def show
    @book = get_book
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      redirect_to book_path(@book), notice: t('flash.book.created')
    else
      render :new
    end
  end

  def edit
    @book = get_book
  end

  def update
    if get_book.update(book_params)
      redirect_to book_path(@book), notice: t('flash.book.updated')
    else
      render :edit
    end
  end

  def destroy
    get_book.destroy
    redirect_to books_path, notice: t('flash.book.deleted')
  end

  private

  def get_book
    Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:authors, :pages, :published_on, :subtitle, :summary, :title, :url)
  end
end
