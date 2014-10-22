require 'spec_helper'
require 'middleware/user_token'

describe UserToken do
  it 'should set a valid user token' do
    user_token = UserToken.new(app)

    user_token.call(env)

    expect(env['USER_TOKEN']).to eq token
  end

  it 'should initialize the app' do
    user_token = UserToken.new(app)

    user_token.call(env)

    expect(app).to have_received :call
  end

  def app
    @_app ||= double('app', call: [])
  end

  def env
    @_env ||= begin 
      env = Hash.new
      env['HTTP_AUTHORIZATION'] = "SHELF token=#{token}"
      env
    end
  end

  def token
    'random'
  end
end
