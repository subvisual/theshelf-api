class ReviewsController < ApplicationController
  before_action :authorize

  def new
    @book = book.decorate
  end

  def create
    ReviewBook.new(book: book, reviewer: current_user, content: review_params).review!

    redirect_to book_path(book.id), success: t('flash.book.reviewed')
  end

  private

  def book
    @_book ||= Book.includes({reviews: :reviewer}).find(params[:id])
  end

  def review_params
    params.require(:review).permit(:body)
  end
end
