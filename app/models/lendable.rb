require_relative 'loan_states'

module Lendable
  def self.included(base)
    LoanStates.all.each do |state_name|
      base.class_eval do
        scope state_name.to_sym, -> { base.where(state: state_name) }
      end
    end
  end

  def initialize(*args, &block)
    super
    self.state ||= LoanStates.initial_state
  end

  def self.define_state_methods(state_names)
    state_names.each do |state_name|
      define_method("make_#{state_name}") do
        update_attributes! state: state_name
        self
      end

      define_method("#{state_name}?") do
        state == state_name
      end
    end
  end

  define_state_methods(LoanStates.all)
end
