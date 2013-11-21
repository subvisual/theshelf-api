require 'services/book_keeper'

describe BookKeeper do
  let(:book) { double("Book", available?: true) }
  let(:book_keeper) { BookKeeper.new(book: book) }

  context "#lend_to" do
    it "lends the book to a user" do
      user = double("User")

      book.should_receive(:lend_to!).with(borrower: user)

      book_keeper.lend_to user: user
    end

    context "book is borrowed" do
      it 'returns false' do
        book.stub(:available?).and_return(false)

        book_keeper.lend_to.should be_false
      end
    end
  end
end
