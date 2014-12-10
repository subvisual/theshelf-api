require_relative 'lendable'
require_relative 'reviewable'
require_relative 'rateable'

class Book < ActiveRecord::Base
  include Lendable
  include Reviewable
  include Rateable

  has_many :borrowers, through: :loans
  has_many :loans

  validates :isbn, uniqueness: true
  validates :title, :state, :authors, presence: true
  validates :state, inclusion: { in: LoanStates.all }

  mount_uploader :cover, CoverUploader

  def current_borrower
    current_loan.borrower
  end

  def current_loan
    loans.by_most_recent.first
  end

  def current_loan_by(borrower)
    loans.where(user_id: borrower.id).by_most_recent.first
  end

  def extendable?
    !available? && current_loan.extendable?
  end

  def self.search(query)
    if query
      where('title LIKE ? or authors LIKE ?', "%#{query}%", "%#{query}%")
    else
      all
    end
  end
end
