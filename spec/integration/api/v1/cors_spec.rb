require 'rails_helper'

describe 'V1 CORS', type: :request do
  it 'sets the Access-Control-Allow-Origin header to allow CORS from anywhere' do
    origin = 'http://corsexample.com/'

    get '/books', nil, request_header.merge(HTTP_ORIGIN: origin)

    expect(response.headers['Access-Control-Allow-Origin']).to eq origin
  end
end
