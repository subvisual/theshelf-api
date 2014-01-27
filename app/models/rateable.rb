module Rateable
  def self.included(base)
    base.class_eval do
      has_many :ratings, dependent: :destroy
    end
  end

  def update_average_rating!
    average_rating = Rating.where(book_id: self.id).where.not(value: 0).average(:value) || NullRating.new.value
    self.update average_rating: average_rating
  end

  def rating_by(rater)
    ratings.where(rater: rater).first || NullRating.new
  end
end
