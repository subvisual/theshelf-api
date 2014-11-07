module API
  module V1
    class BooksController < ApplicationController
      before_action :authenticate_user!

      def index
        books = Book.all

        render json: books, root: false
      end

      def show
        render json: Book.find(params[:id]), root: false
      end

      def destroy
        book = Book.find(params[:id])
        book.destroy
        render json: book, root: false
      end

      def update
        book = Book.find(params[:id])
        book.update(book_params)
        render json: book, root: false
      end

      def create
        book = Book.new(book_params)
        if book.save
          render json: book, status: :created, location: book_url(book), root: false
        else
          head :bad_request
        end
      end

      private

      def book_params
        params.require(:book).permit(:authors, :owner, :pages, :published_on, :subtitle, :summary, :title, :url, :cover, :cover_cache, :isbn)
      end
    end
  end
end
