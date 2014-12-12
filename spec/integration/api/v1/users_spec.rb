require 'rails_helper'

describe 'V1 Users API', type: :request do
  context 'get /users' do
    it 'returns the list of users' do
      users = build_stubbed_list(:user, 10)
      allow(User).to receive(:all).and_return(users)

      get '/users', nil, authenticated_request_header(user: users.first)

      expect(response).to be_success
      expect(parsed_response.length).to eq 10
    end
  end

  context 'get /users/:id' do
    it 'returns information about a user' do
      get "/users/#{user.id}", nil, authenticated_request_header(user: user)

      expect(response).to be_success
      expect(parsed_response[:id]).to eq user.id
      expect(parsed_response[:email]).to eq user.email
      expect(parsed_response[:first_name]).to eq user.first_name
      expect(parsed_response[:last_name]).to eq user.last_name
    end

    it "fails if a user doesn't exist" do
      get '/users/9999', nil, authenticated_request_header(user: user)

      expect(response).not_to be_success
    end
  end

  context 'post /users' do
    it 'sends an authorization token' do
      user = build_stubbed(:user)
      allow(user).to receive(:save).and_return(true)
      allow(User).to receive(:new).and_return(user)

      post '/users', user_params, request_header

      expect(response).to be_success
      expect(parsed_response[:authentication_token]).to eql user.authentication_token
    end

    it 'sends an invalid request response' do
      user = build_stubbed(:user)
      allow(user).to receive(:save).and_return(false)
      allow(User).to receive(:new).and_return(user)

      post '/users', user_params, request_header

      expect(response).not_to be_success
    end

    private

    def user_params
      {
        email: 'me@gmail.com',
        password: 'pass123456',
        first_name: 'Bruno',
        last_name: 'Azevedo'
      }
    end
  end
end
