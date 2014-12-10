require 'rails_helper'

describe 'V1 Users API', type: :request do
  context 'post /book/:id/loan' do
    it 'borrows a book' do
      book = build_stubbed(:book)
      allow(Book).to receive(:find).and_return(book)

      post "/books/#{book.id}/loan", {}, authenticated_request_header(user: user)

      expect(response).to be_success
      expect(parsed_response).to have_key(:started_at)
      expect(parsed_response).to have_key(:ends_at)
      expect(parsed_response).to have_key(:closed)
    end

    it "fails to borrow when it's already borrowed" do
      book = create(:lent_book, borrower: user)

      post "/books/#{book.id}/loan", {}, authenticated_request_header(user: user)

      expect(response).not_to be_success
    end
  end

  context 'delete /book/:id/loan' do
    it 'finishes a loan' do
      book = create(:lent_book, borrower: user)

      delete "/books/#{book.id}/loan", {}, authenticated_request_header(user: user)

      expect(response).to be_success
      expect(parsed_response).to have_key(:closed_at)
    end

    it "fails to finish a loan when it wasn't borrowed by me" do
      book = create(:lent_book, borrower: create(:user))

      delete "/books/#{book.id}/loan", {}, authenticated_request_header(user: user)

      expect(response).not_to be_success
    end
  end

  context 'update /book/:id/loan' do
    it 'extends a loan' do
      book = create(:lent_book, borrower: user)

      Timecop.freeze(25.day.from_now) do
        patch "/books/#{book.id}/loan", { extended: true }, authenticated_request_header(user: user)
      end

      expect(response).to be_success
      expect(parsed_response[:extended]).to be true
    end

    it "fails to extend a loan when it's already extended" do
      book = create(:lent_book, borrower: user)

      Timecop.freeze(25.days.from_now) do
        book.current_loan.extend!

        patch "/books/#{book.id}/loan", { extended: true }, authenticated_request_header(user: user)
      end

      expect(response).not_to be_success
    end
  end
end
