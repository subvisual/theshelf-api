require 'spec_helper'

describe 'books/_rating_show.slim' do
  it 'renders a label with the average rating as title' do
    book = build_stubbed(:book, average_rating: BigDecimal(2.0, 2))

    render 'books/rating_show', book: book.decorate

    expect(rendered).to match /title="2\.0"/
  end

  it 'renders two full stars for an average rating of 2.0' do
    book = build_stubbed(:book, average_rating: BigDecimal(2.0, 2))

    render 'books/rating_show', book: book.decorate

    expect(rendered.scan(/rating-label full/)).to have(2).items
  end

  it 'renders one full star and one half star for an average rating between 1.1 and 2.0' do
    book = build_stubbed(:book, average_rating: BigDecimal(1.4, 2))

    render 'books/rating_show', book: book.decorate

    expect(rendered.scan(/rating-label (?:full|half)/)).to have(2).items
  end
end
