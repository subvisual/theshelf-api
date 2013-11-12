class Ability
  include CanCan::Ability

  def initialize(user)
    send user.role if user
  end

  def registered
    can :read, :all
    can :manage, Book
  end

  def admin
    registered
    can :manage, :all
  end
end
