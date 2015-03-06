require 'rails_helper'
require 'services/book_keeper'

describe BookKeeper, type: :model do
  context '#lend_to!' do
    it "changes the book's state to lent" do
      user = build_stubbed(:user)
      book = build_stubbed(:book)
      book_keeper = BookKeeper.new(book: book)

      book_keeper.lend_to!(borrower: user)

      expect(book).to be_lent
    end

    it "saves the book's borrower" do
      user = build(:user)
      book = build(:book)
      book_keeper = BookKeeper.new(book: book)

      book_keeper.lend_to!(borrower: user)

      expect(book.current_borrower).to eq user
    end

    it 'starts the loan' do
      user = build_stubbed :user
      book = build_stubbed(:book)
      book_keeper = BookKeeper.new(book: book)

      book_keeper.lend_to!(borrower: user)

      expect(book.current_loan).not_to be_closed
    end

    it 'returns false if the book is already borrowed' do
      book = double('Book', available?: false)
      book_keeper = BookKeeper.new(book: book)

      expect(book_keeper.lend_to!).to be_falsey
    end
  end

  context '#return_by!' do
    it "changes the book's state to available" do
      user = build :user
      book = create(:lent_book, borrower: user)
      book_keeper = BookKeeper.new(book: book)

      book_keeper.return_by!(borrower: user)

      expect(book).to be_available
    end

    it 'ends the loan' do
      user = build :user
      book = create(:lent_book, borrower: user)
      book_keeper = BookKeeper.new(book: book)

      book_keeper.return_by!(borrower: user)

      expect(book.current_loan).to be_closed
    end

    it 'increments the number of readings' do
      user = build :user
      book = create(:lent_book, borrower: user)
      book_keeper = BookKeeper.new(book: book)

      expect { book_keeper.return_by!(borrower: user) }.to change { book.readings }.by(1)
    end

    it "returns false if the book wasn't borrowed by me" do
      current_borrower = double('User')
      another_user = double('User')
      book = double('Book', lent?: true, current_borrower: current_borrower)
      book_keeper = BookKeeper.new(book: book)

      expect(book_keeper.return_by!(borrower: another_user)).to be_falsey
    end

    it "returns false if the book isn't lent" do
      book = double('Book', lent?: false)
      book_keeper = BookKeeper.new(book: book)

      expect(book_keeper.return_by!(borrower: double('User'))).to be_falsey
    end
  end

  context '#extend_loan!' do
    it 'extends the ending period' do
      user = build :user
      book = create(:lent_book, borrower: user)
      old_period = book.current_loan.ends_at
      book_keeper = BookKeeper.new(book: book)

      Timecop.freeze(old_period - 1.day) do
        book_keeper.extend_loan! borrower: user
      end

      new_period = old_period + 15.days
      expect(book.current_loan.ends_at).to eq new_period
    end

    it 'remains lent' do
      user = build :user
      book = create(:lent_book, borrower: user)
      old_state = book.state
      book_keeper = BookKeeper.new(book: book)

      book_keeper.extend_loan! borrower: user

      expect(book.state).to eq old_state
    end

    it "returns false if the book isn't lent" do
      loan = double('Loan', :extend! => true)
      book = double('Book', extendable?: false, current_loan_by: loan)
      book_keeper = BookKeeper.new(book: book)

      expect(book_keeper.extend_loan!).not_to be
    end
  end
end
