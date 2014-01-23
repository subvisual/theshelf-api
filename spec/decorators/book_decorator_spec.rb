require 'spec_helper'

describe BookDecorator do
  context '#average_rating' do
    it 'returns the average_rating with only 1 decimal digit as a string' do
      book = build_stubbed(:book, average_rating: BigDecimal(3.33333, 6))
      book.decorate.average_rating.should eq "3.3"
    end
  end

  context '#star_tag' do
    it 'renders the a labels with the average rating as title' do
      book = build_stubbed(:book, average_rating: BigDecimal(2.0, 2))

      book.decorate.star_tag(1).should match /title="2\.0"/
    end

    it 'renders two full stars for an average rating of 2.0' do
      book = build_stubbed(:book, average_rating: BigDecimal(2.0, 2))
      book.decorate.star_tag(1).should include "full"
      book.decorate.star_tag(2).should include "full"
    end

    it 'renders one full star and one half star for an average rating between 1.1 and 2.0' do
      book = build_stubbed(:book, average_rating: BigDecimal(1.4, 2))
      book.decorate.star_tag(1).should include "full"
      book.decorate.star_tag(2).should include "half"
    end
  end
end
