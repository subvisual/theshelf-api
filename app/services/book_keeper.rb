class BookKeeper
  def initialize(book: nil)
    @book = book
  end

  def lend_to(user: nil)
    return false unless book.available?

    book.lend_to! borrower: user
  end

  private
  attr_reader :book
end
