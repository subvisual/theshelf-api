module WebmockHelpers
  require 'webmock/cucumber'

  def stub_goodreads_request
    init_goodreads_api
    stub_isbn_search
    stub_cover_download
  end

  private

  def init_goodreads_api
    @api_key = '123456789'
    Goodreads.configure(
      api_key: @api_key,
      api_secret: 'GOODREADS_API_SECRET'
    )
  end

  def stub_isbn_search
    stub_request(:get,
      'http://www.goodreads.com/book/isbn' +
      '?format=xml&isbn=9780553801477&key=' +
      @api_key).
      to_return(status: 200, body: File.new('./spec/fixtures/goodreads_response.xml'))
  end

  def stub_cover_download
    stub_request(:get, 'http://d.gr-assets.com/books/1329188207m/13422727.jpg').
      to_return(status: 200, body: File.new('./spec/fixtures/images/import_example.jpg'))
  end
end
