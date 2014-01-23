module Rateable
  def update_average_rating!
    average_rating = Rating.where(book_id: self.id).where.not(value: 0).average(:value)
    self.update average_rating: average_rating
  end
end
