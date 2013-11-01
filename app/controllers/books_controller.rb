class BooksController < ApplicationController

  def index
    @books = Book.all.decorate
  end

  def show
    @book = book.decorate
  end

  private

  def book
    Book.find(params[:id])
  end

end
