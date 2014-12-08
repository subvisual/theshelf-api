require 'rails_helper'

describe 'V1 Authentication', type: :request do
  context 'authorized request' do
    it 'responds with success' do
      get '/books', nil, authenticated_request_header(user: user)

      expect(response).to be_success
    end

    it 'responds with the right content type' do
      get '/books', nil, authenticated_request_header(user: user)

      expect(response.content_type).to be Mime::JSON_V1
    end
  end

  context 'unauthorized request' do
    it 'sends the correct status code' do
      get '/books', nil, request_header

      expect(response).to have_http_status(:unauthorized)
    end

    it 'responds with the right content type' do
      get '/books', nil, request_header

      expect(response.content_type).to be Mime::JSON_V1
    end

    it 'responds with the right realm' do
      get '/books', nil, request_header

      expect(response.headers['WWW-Authenticate']).to eql 'Token realm="Application"'
    end
  end
end
