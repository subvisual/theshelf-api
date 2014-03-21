require 'services/book_keeper'

describe BookKeeper do

  context '#lend_to!' do
    it "changes the book's state to lent" do
      user = build_stubbed(:user)
      book = build_stubbed(:book)
      book_keeper = BookKeeper.new(book: book)

      book_keeper.lend_to!(borrower: user)

      book.should be_lent
    end

    it "saves the book's borrower" do
      user = build(:user)
      book = build(:book)
      book_keeper = BookKeeper.new(book: book)

      book_keeper.lend_to!(borrower: user)

      book.current_borrower.should eq user
    end

    it 'starts the loan' do
      user = build_stubbed :user
      book = build_stubbed(:book)
      book_keeper = BookKeeper.new(book: book)

      book_keeper.lend_to!(borrower: user)

      book.current_loan.should_not be_closed
    end

    it 'returns false if the book is already borrowed' do
      book = double("Book", available?: false)
      book_keeper = BookKeeper.new(book: book)

      book_keeper.lend_to!.should be_false
    end
  end

  context '#return_by!' do
    it "changes the book's state to available" do
      user = build :user
      book = create(:lent_book, borrower: user)
      book_keeper = BookKeeper.new(book: book)

      book_keeper.return_by!(borrower: user)

      book.should be_available
    end

    it 'ends the loan' do
      user = build :user
      book = create(:lent_book, borrower: user)
      book_keeper = BookKeeper.new(book: book)

      book_keeper.return_by!(borrower: user)

      book.current_loan.should be_closed
    end

    it 'increments the number of readings' do
      user = build :user
      book = create(:lent_book, borrower: user)
      book_keeper = BookKeeper.new(book: book)

      expect { book_keeper.return_by!(borrower: user) }.to change{ book.readings }.by(1)
    end

    it "returns false if the book wasn't borrowed by me" do
      current_borrower = double('User')
      another_user = double('User')
      book = double('Book', lent?: true, current_borrower: current_borrower)
      book_keeper = BookKeeper.new(book: book)

      book_keeper.return_by!(borrower: another_user).should be_false
    end

    it "returns false if the book isn't lent" do
      book = double('Book', lent?: false)
      book_keeper = BookKeeper.new(book: book)

      book_keeper.return_by!(borrower: double('User')).should be_false
    end

  end
end
