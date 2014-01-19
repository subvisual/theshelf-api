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
      redirect_to book_path(@book), notice: t('flash.book.created')
    else
      render :new
    end
  end

  def edit
    @book = book.decorate
  end

  def update
    if book.update(book_params)
      redirect_to book_path(@book), notice: t('flash.book.updated')
    else
      render :edit
    end
  end

  def destroy
    book.destroy
    redirect_to books_path, notice: t('flash.book.deleted')
  end

  def borrow
    BookKeeper.new(book: book).lend_to!(borrower: current_user)

    redirect_to books_path
  end

  def return
    BookKeeper.new(book: book).return_by!(borrower: current_user)

    redirect_to new_review_book_path
  end

  def new_review
    @book = book.decorate
  end

  def create_review
    ReviewBook.new(book: book, reviewer: current_user, content: review_params).review!

    redirect_to book_path(book.id)
  end

  private

  def book
    @_book ||= Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:authors, :pages, :published_on, :subtitle, :summary, :title, :url, :cover, :cover_cache)
  end

  def review_params
    params.require(:review).permit(:body)
  end
end
