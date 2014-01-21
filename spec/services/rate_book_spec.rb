require 'spec_helper'
require 'services/rate_book'

describe RateBook do
  context "#rate!" do
    let(:user) { create :user }
    let(:book) { create :book }

    it 'requires a book, a rater and a rating value' do
      rate_book = RateBook.new(book: nil, rater: nil, rating: nil)

      rate_book.rate!.should be_false
    end

    it "rates a book for a user" do
      expect {
        RateBook.new(book: book, rater: user, rating: 3).rate!
      }.to change { Rating.all.size }.by(1)
    end

    it "updates a book's rating for a user" do
      old_rating = 3
      new_rating = 2
      RateBook.new(book: book, rater: user, rating: old_rating).rate!

      expect {
        RateBook.new(book: book, rater: user, rating: new_rating).rate!
      }.to change { Rating.all.size }.by(0)
    end

    it "updates the book's average rating" do
      rating = 3

      book.shoud_receive(:update_average_rating).with(average_rating: rating)

      RateBook.new(book: book, rater: user, rating: rating).rate!
    end
  end
end
