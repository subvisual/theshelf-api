require 'rails_helper'

describe 'Books API', type: :request do
  it 'sends a list of books' do
    allow(Book).to receive(:all).and_return(build_stubbed_list(:book, 10))

    get '/books', nil, {'accept' => 'application/json; version=1'}

    expect(response).to be_success
    expect(parsed_response.length).to eq 10
  end
end
