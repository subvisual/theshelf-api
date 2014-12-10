module API
  module V1
    class LoansController < ApplicationController
      authorize_resource

      def create
        if borrow_book!
          render json_v1: book.current_loan
        else
          head :unprocessable_entity
        end
      end

      def destroy
        if return_book!
          render json_v1: book.current_loan
        else
          head :unprocessable_entity
        end
      end

      def update
        if extend_book!
          render json_v1: book.current_loan
        else
          head :unprocessable_entity
        end
      end

      private

      def borrow_book!
        BookKeeper.new(book: book).lend_to!(borrower: current_user)
      end

      def return_book!
        BookKeeper.new(book: book).return_by!(borrower: current_user)
      end

      def extend_book!
        return false unless params[:extended] == 'true'
        BookKeeper.new(book: book).extend_loan!(borrower: current_user)
      end

      def book
        @_book ||= Book.find(params[:book_id])
      end
    end
  end
end
