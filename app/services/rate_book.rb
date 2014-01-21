class RateBook
  def initialize(book: nil, rater: nil, rating: nil)
    @book = book
    @rater = rater
    @rating_value = rating
  end

  def rate!
    return false unless book && rater && rating_value

    rating = Rating.where(book: book, rater: rater).first_or_initialize
    rating.value = rating_value
    rating.save
  end

  private
  attr_reader :book, :rater, :rating_value
end
