class ReviewBook
  def initialize(book: nil, reviewer: nil, content: nil)
    @book = book
    @reviewer = reviewer
    @content = content
  end

  def review!
    return false unless content
    review = Review.new book: book, reviewer: reviewer, body: content[:body]
    review.save
  end

  private

  attr_reader :book, :reviewer, :content
end
