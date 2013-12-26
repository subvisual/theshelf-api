class BookKeeper
  def initialize(book: nil)
    @book = book
  end

  def lend_to(user: nil)
    return false unless book.available?

    book.lend_to! borrower: user
  end

  def return_by!(borrower: nil)
    return false unless book.lent? && book.current_borrower == borrower

    ActiveRecord::Base.transaction do
      book.make_available
      book.current_loan.update closed_at: Time.now
    end
  end

  private
  attr_reader :book
end
