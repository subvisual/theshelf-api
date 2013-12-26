require 'spec_helper'

describe Book do
  it_behaves_like 'a lendable resource'

  let(:book) { create(:book) }
  let(:user) { create(:user) }

  context '#lend_to!' do
    it "changes the book's state to lent" do
      book = build(:book)

      book.lend_to! borrower: user

      book.should be_lent 
    end

    it "saves the book's borrower" do
      book.lend_to! borrower: user

      book.current_borrower.should eq user
    end
  end
end
