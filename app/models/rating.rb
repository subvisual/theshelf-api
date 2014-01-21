class Rating < ActiveRecord::Base
  belongs_to :book
  belongs_to :rater, foreign_key: :user_id, class_name: 'User'

  validates_presence_of :book, :rater, :value
end
