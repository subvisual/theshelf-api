require 'spec_helper'

describe Book do
  it_behaves_like 'a lendable resource'
  it_behaves_like 'a reviewable resource'

  context '.search' do
    it 'returns all books' do
      create(:book)
      query = ""

      expect( Book.search(query) ).not_to be_empty
    end

    it 'returns the matched books' do
      book = create(:book)
      query = book.title

      expect( Book.search(query).first.title ).to eq query
    end

    it 'returns nothing' do
      create(:book, title: "some title")
      query = "nothing"

      expect( Book.search(query) ).to be_empty
    end
  end
end
