require_relative 'lendable'

class Book < ActiveRecord::Base
  include Lendable
  has_many :borrowers, through: :loans
  has_many :loans

  validates :title, :state, :authors, presence: true
  validates :state, inclusion: { in: LoanStates.all }

  mount_uploader :cover, CoverUploader

  def current_borrower
    current_loan.borrower
  end

  def current_loan
    loans.by_most_recent.first
  end

  def lend_to!(borrower: nil)
    transaction do
      Loan.new(borrower: borrower, book: self.make_lent).start!
    end
  end
end
