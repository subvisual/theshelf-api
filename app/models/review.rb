class Review < ActiveRecord::Base
  scope :in_order, -> { order('created_at asc') }
  scope :by_most_recent, -> { order('created_at desc') }

  belongs_to :reviewer, foreign_key: :user_id, class_name: 'User'
  belongs_to :book, counter_cache: true

  validates_presence_of :book, :reviewer, :body
end
