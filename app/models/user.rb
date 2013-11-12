require_relative 'authorizable'

class User < ActiveRecord::Base
  include Clearance::User
  include Authorizable

  validates :first_name, :last_name, presence: true
  validates :role, presence: true, inclusion: { in: UserRoles.all }
  validates :email, presence: true, uniqueness: true
end
