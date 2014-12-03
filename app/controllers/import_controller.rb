class ImportController < ApplicationController
  def import
    book_params = ImportBook.new(book_import_params[:isbn]).perform
    @book = Book.new(book_params)

    if @book.save
      redirect_with_success
    else
      redirect_with_errors
    end
  end

  private

  attr_reader :book

  def redirect_with_errors
    if book_found?
      redirect_with_save_error
    else
      redirect_with_import_failed
    end
  end

  def book_found?
    @book.isbn?
  end

  def redirect_with_success
    redirect_to book_path(@book), flash: { success: t('flash.book.created') }
  end

  def redirect_with_save_error
    redirect_to :back, flash: { error: @book.errors.full_messages.first }
  end

  def redirect_with_import_failed
    redirect_to :back, flash: { error: t('flash.book.not_found') }
  end

  def book_import_params
    params.require(:import_book).permit(:isbn)
  end
end
