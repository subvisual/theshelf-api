module V1
  class BooksController < ApplicationController
    def index
      books = Book.all

      render json: books
    end

    def show
      render json: Book.find(params[:id])
    end

    def destroy
      book = Book.find(params[:id])
      book.destroy
      render json: book
    end
  end
end
