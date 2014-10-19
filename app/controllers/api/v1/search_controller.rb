class Api::V1::SearchController < ApplicationController
  before_action :authorize

  respond_to :json

  def search
    books = Book.search(search_params).decorate

    render json: books.map(&:as_json), root: nil
  end

  private

  def search_params
    params.permit(:search_box)[:search_box]
  end
end
