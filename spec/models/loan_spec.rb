require 'spec_helper'

describe Loan, :type => :model do
  context '#start!' do
    it 'needs a book and borrower' do
      expect {
        Loan.new.start!
      }.to raise_error
    end
  end

  context '#extendable?' do
    it "is true when less than one week of loan remains and it hasn't been extended yet" do
      loan = build_stubbed(:loan, ends_at: 7.days.from_now, started_at: Time.now)

      expect(loan).to be_extendable
    end

    it "is false when the loan has been extended" do
      loan = build_stubbed(:loan)
      loan.start!
      loan.extend!

      expect(loan).not_to be_extendable
    end

    it "is false when more than one week of loan remains" do
      loan = build_stubbed(:loan, ends_at: 8.days.from_now)

      expect(loan).not_to be_extendable
    end
  end
end
