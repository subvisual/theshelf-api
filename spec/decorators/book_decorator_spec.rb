require 'spec_helper'

describe BookDecorator do
  context '#availability' do
    it "returns an available string if the state is 'available'" do
      book = create(:book)
      book.make_available

      availability = BookDecorator.decorate(book).availability

      availability.should eq I18n.t('books.state.available')
    end
  end
end
