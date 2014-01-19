require_relative 'lendable'
require_relative 'reviewable'

class Book < ActiveRecord::Base
  include Lendable
  include Reviewable

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
end
