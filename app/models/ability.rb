class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user
    send user.role if user
  end

  def registered
    can :read, :all
    can :manage, Book
    can [:create, :update], Loan
    can :destroy, Loan, borrower: user
  end

  def admin
    registered
    can :manage, :all
  end

  private

  attr_reader :user
end
