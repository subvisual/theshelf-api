class BookKeeper
  def initialize(book: nil)
    @book = book
  end

  def lend_to!(borrower: nil)
    return false unless book.available?

    ActiveRecord::Base.transaction do
      Loan.new(borrower: borrower, book: book.make_lent).start!
    end
  end

  def return_by!(borrower: nil)
    return false unless book.lent? && book.current_borrower == borrower

    ActiveRecord::Base.transaction do
      book.make_available
      book.increment!(:readings)
      book.current_loan.update closed_at: Time.now
    end
  end

  def extend_loan!(borrower: nil)
    return false unless book.extendable?

    book.current_loan_by(borrower).extend!
  end

  private

  attr_reader :book
end
