module Reviewable
  def self.included(base)
    base.class_eval do
      has_many :reviews, dependent: :destroy
    end
  end

  def reviews_by(reviewer)
    reviews.in_order.where(reviewer: reviewer)
  end

  def last_review_by(reviewer)
    reviews.by_most_recent.where(reviewer: reviewer).first
  end

  def total_reviews
    reviews.size
  end
end
