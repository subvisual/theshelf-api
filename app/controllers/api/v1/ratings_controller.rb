class Api::V1::RatingsController < ApplicationController
  before_action :authorize

  respond_to :json

  def rate
    RateBook.new(book: book, rater: current_user, rating: params.require(:rating).to_i).rate!

    render json: { head: :no_content }
  end

  def average
    local_variables = { book: book.decorate, rating_value: book.decorate.average_rating }
    partial = render_to_string('books/_rating_show', layout: false, locals: local_variables)
    render json: { attachmentPartial: partial }
  end

  private

  def book
    @_book ||= Book.includes({reviews: :reviewer}).find(params[:book_id])
  end

  def rate_params
    params.require(:rating)
  end
end
