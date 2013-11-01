require_relative 'lendable'

class Book < ActiveRecord::Base
  include Lendable

  validates :title, :state, :authors, presence: true
  validates :state, inclusion: { in: LoanStates.all }
end
