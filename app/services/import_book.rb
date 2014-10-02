class ImportBook
  def initialize(isbn)
    @isbn = isbn
  end

  def perform
    import_params
    format_response
  end

  private

  attr_reader :isbn

  def import_params
    goodreads_api = Goodreads::Client.new

    begin
      @book = goodreads_api.book_by_isbn(@isbn)
    rescue Goodreads::NotFound
      {}
    end
  end

  def format_response
    date = convert_date
    authors = author_name
    {
      title: @book.title,
      summary: @book.description,
      pages: @book.num_pages,
      authors: authors,
      published_on: date,
      remote_cover_url: @book.image_url,
      isbn: @book.isbn13
    }
  end

  def convert_date
    return if @book.publication_year.empty?

    year = @book.publication_year.to_i
    month = (@book.publication_month.presence || '01').to_i
    day = (@book.publication_day.presence || '01').to_i

    Date.new(year, month, day)
  end

  def author_name
    author = @book.authors.author
    if author.is_a?(Array)
      author.map(&:name).join(', ')
    else
      author.name
    end
  end
end
