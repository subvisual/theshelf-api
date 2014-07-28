class BookKeeperController < ApplicationController
  before_action :authorize

  def borrow
    BookKeeper.new(book: book).lend_to!(borrower: current_user)

    flash[:success] = t('flash.book.borrowed')
    redirect_to books_path
  end

  def return
    BookKeeper.new(book: book).return_by!(borrower: current_user)

    flash[:success] = t('flash.book.returned')
    redirect_to review_book_path
  end

  def extend
    book_keeper = BookKeeper.new book: book
    book_keeper.extend_loan! borrower: current_user

    redirect_to books_path, notice: I18n.t('flash.book.extended')
  end

  private

  def book
    @_book ||= Book.includes({reviews: :reviewer}).find(params[:id])
  end
end
