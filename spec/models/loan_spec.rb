require 'spec_helper'

describe Loan, :type => :model do
  context '#start!' do
    it 'needs a book and borrower' do
      expect {
        Loan.new.start!
      }.to raise_error
    end
  end
end
