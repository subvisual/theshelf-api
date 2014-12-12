require 'rails_helper'

describe 'V1 Session API', type: :request do
  context 'post /users' do
    it 'return an authorization token for the user' do
      user = create :user, user_params

      post '/session', { user: user_params }, request_header

      expect(response).to be_success
      expect(parsed_response[:authentication_token]).to eql user.authentication_token
    end

    it "fails when the user doesn't exist" do
      post '/session', { user: { email: 'asd', password: 'asd' } }, request_header

      expect(response).not_to be_success
    end

    it 'fails when password is wrong' do
      user = create :user

      post '/session', { user: { email: user.email, password: 'asd' } }, request_header

      expect(response).not_to be_success
    end

    private

    def user_params
      {
        email: 'me@gmail.com',
        password: 'pass123456'
      }
    end
  end
end
