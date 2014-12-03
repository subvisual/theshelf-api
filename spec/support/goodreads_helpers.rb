require 'nokogiri'

def goodreads_mock_response
  doc = parse_goodreads_response
  {
    isbn: doc.css('book').first.css('isbn13').first.content,
    title: doc.css('book').first.css('title').first.content
  }
end

private

def parse_goodreads_response
  Nokogiri::XML(goodreads_response)
end

def goodreads_response
  File.new('./spec/fixtures/goodreads_response.xml')
end
