module V1
  class BooksController < ApplicationController
    def index
      books = Book.all

      render json: books
    end
  end
end
