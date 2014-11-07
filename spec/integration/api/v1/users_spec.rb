require 'rails_helper'

describe 'V1 Users API', type: :request do
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
