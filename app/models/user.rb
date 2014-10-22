require_relative 'authorizable'
require_relative 'authenticable'

class User < ActiveRecord::Base
  include Authorizable
  include Authenticable

  devise :database_authenticatable, :registerable, :recoverable

  mount_uploader :avatar, AvatarUploader

  has_many :borrowed_books, through: :loans, source: :book
  has_many :loans

  validates :first_name, :last_name, presence: true
  validates :role, presence: true, inclusion: { in: UserRoles.all }
  validates :email, presence: true, uniqueness: true

  def currently_borrowed_books
    Book.joins(:loans).
      where(loans: { user_id: id, closed_at: nil })
  end

  def read_books
    Book.joins(:loans).
      where(loans: { user_id: id }).where.not(loans: { closed_at: nil }).uniq
  end
end
