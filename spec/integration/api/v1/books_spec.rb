require 'rails_helper'

describe 'V1 Books API', type: :request do
  context 'get /books' do
    it 'sends a list of books' do
      allow(Book).to receive(:all).and_return(build_stubbed_list(:book, 10))

      get '/books', nil, authenticated_request_header(user: user)

      expect(response).to be_success
      expect(parsed_response.length).to eq 10
    end
  end

  context 'get /book' do
    it 'sends the details of a book' do
      book = build_stubbed(:book)
      allow(Book).to receive(:find).and_return(book)

      get "/books/#{book.id}", nil, authenticated_request_header(user: user)

      expect(response).to be_success
      expect(parsed_response[:id]).to eq book.id
    end

    it 'sends an error code' do
      get '/books/99', nil, authenticated_request_header(user: user)

      expect(response).to be_not_found
    end
  end

  context 'delete /book' do
    it 'deletes a book' do
      book = create :book
      allow(Book).to receive(:find).and_return(book)

      delete "/books/#{book.id}", nil, authenticated_request_header(user: user)

      expect(response).to be_success
      expect(parsed_response[:id]).to eq book.id
    end

    it 'sends an error code' do
      delete '/books/99', nil, authenticated_request_header(user: user)

      expect(response).to be_not_found
    end
  end

  context 'update /book' do
    it 'updates a book' do
      book = create :book
      book_params = {
        book: {
          title: 'testAPI'
        }
      }

      put "/books/#{book.id}", book_params, authenticated_request_header(user: user)

      expect(response).to be_success
      expect(parsed_response[:title]).to eq book_params[:book][:title]
    end

    it 'sends an error code on wrong params' do
      book = create :book

      put "/books/#{book.id}", nil,  authenticated_request_header(user: user)

      expect(response).to be_bad_request
    end
  end

  context 'create /book' do
    it 'creates a book' do
      book_attributes = attributes_for(:book)

      post '/books', { book: book_attributes }, authenticated_request_header(user: user)

      expect(response).to be_successful
      expect(parsed_response[:title]).to eq book_attributes[:title]
    end

    it 'sends missing attributes error code' do
      book_attributes = { title: 'random' }

      post '/books/', { 'book' => book_attributes }, authenticated_request_header(user: user)

      expect(response).to be_bad_request
    end
  end
end
