module LoanStates
  STATES = %w(available lent unavailable)

  private_constant :STATES

  def self.all
    STATES
  end

  def self.initial_state
    STATES.first
  end
end
