require_relative 'lendable'

class Book < ActiveRecord::Base
  include Lendable
  has_many :borrowers, through: :loans
  has_many :loans

  validates :title, :state, :authors, presence: true
  validates :state, inclusion: { in: LoanStates.all }

  def current_borrower
    borrowers.first
  end

  def lend_to!(borrower: nil)
    transaction do
      Loan.new(borrower: borrower, book: self.make_lent).start!
    end
  end
end
