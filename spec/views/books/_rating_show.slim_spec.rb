require 'spec_helper'

describe 'books/_rating_show.slim' do
  let(:user) { create(:user) }

  it 'renders a label with the average rating as title' do
    book = Book.new

    render 'books/rating_show', book: book.decorate, rating_value: 2

    expect(rendered).to match /title="2\.0"/
  end

  it 'renders two full stars for an average rating of 2.0' do
    book = Book.new

    render 'books/rating_show', book: book.decorate, rating_value: 2

    expect(rendered.scan(/rating-label full/)).to have(2).items
  end

  it 'renders one full star and one half star for an average rating between 1.1 and 2.0' do
    book = Book.new

    render 'books/rating_show', book: book.decorate, rating_value: 1.5

    expect(rendered.scan(/rating-label (?:full|half)/)).to have(2).items
  end
end
