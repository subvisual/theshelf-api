class RateBook
  def initialize(book: nil, rater: nil, rating: nil)
    @book = book
    @rater = rater
    @rating_value = rating
  end

  def rate!
    return false unless book && rater && rating_value

    ActiveRecord::Base.transaction do
      save_rating
      update_average_rating
    end
  end

  private
  attr_reader :book, :rater, :rating_value

  def save_rating
    rating = Rating.where(book: book, rater: rater).first_or_initialize

    if RatingValues.valid?(rating_value)
      rating.update value: rating_value
    else
      rating.delete
    end
  end

  def update_average_rating
    book.update_average_rating!
  end
end
