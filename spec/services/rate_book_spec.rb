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

    context "the book is already rated by the user" do
      it "updates the rating when the given rating valid" do
        old_rating = 3
        RateBook.new(book: book, rater: user, rating: old_rating).rate!
        new_rating = 2

        expect {
          RateBook.new(book: book, rater: user, rating: new_rating).rate!
        }.to change { Rating.all.size }.by(0)
      end

      it "deletes the rating when the given rating is invalid" do
        old_rating = 3
        RateBook.new(book: book, rater: user, rating: old_rating).rate!
        new_rating = 0

        expect {
          RateBook.new(book: book, rater: user, rating: 0).rate!
        }.to change { Rating.all.size }.by(-1)
      end
    end

    it "updates the book's average rating" do
      rating = 3

      book.should_receive(:update_average_rating!)

      RateBook.new(book: book, rater: user, rating: rating).rate!
    end
  end
end
