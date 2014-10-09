require 'rails_helper'

describe BookDecorator, type: :model do
  context '#average_rating' do
    it 'returns the average_rating with only 1 decimal digit as a string' do
      book = build_stubbed(:book, average_rating: BigDecimal(3.33333, 6))
      expect(book.decorate.average_rating).to eq "3.3"
    end
  end
end
