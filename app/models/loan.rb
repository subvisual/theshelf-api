class Loan < ActiveRecord::Base
  scope :by_most_recent, -> { order('started_at desc') }

  belongs_to :borrower, foreign_key: :user_id, class_name: 'User'
  belongs_to :book

  validates_presence_of :book, :borrower

  def start!
    starts_at = Time.now
    ends_at = 30.days.from_now
    save!
  end

  def closed?
    !!closed_at
  end
end
