step "there are (available) books" do
  @books = BookDecorator.decorate_collection(create_list(:available_book, 2))
end

step "there are no books borrowed by me" do
  @books = [create(:lent_book, borrower: create(:user))]
end

step "there are no books" do
end

step "I've borrowed a book" do
  @book = create(:lent_book, borrower: @user).decorate
end

step "there isn't a book with title :title" do |title|
  @title = title
  expect(page).not_to have_content title
end

step "I've read a book" do
  @read_book = create(:read_book, borrower: @user)
end

step "I borrow an available book" do
  within '#book-list' do
    first('.btn-positive').click
  end
end

step "I change the book's title" do
  @new_title = "Random title"
  fill_in 'book_title', with: @new_title
end

step "I submit the book" do
  click_on I18n.t('books.submit')
end

step "I submit the ISBN" do
  stub_goodreads_request
  click_on I18n.t('books.isbn_submit')
end

step "I submit the review" do
  find(".review-form .btn-positive").click
end

step "I fill the book form" do
  @book ||= build(:book)
  within("#new_book") do
    fill_in 'book_title', with: @book.title
    fill_in 'book_authors', with: @book.authors
  end
end

step "I fill the ebook form" do
  @book ||= build(:ebook)
  within("#new_book") do
    fill_in 'book_title', with: @book.title
    fill_in 'book_authors', with: @book.authors
    fill_in 'book_ebook', with: @book.ebook
  end
end

step "I fill the ISBN form" do
  @book ||= build(:book, goodreads_mock_response)
  within("#import-book-form") do
    fill_in 'isbn-input', with: @book.isbn
  end
end

step "add myself as the book's owner" do
  @book.owner = "King Arthur"
  within("#new_book") do
    fill_in 'book_owner', with: @book.owner
  end
end

step "I borrow the book" do
  first(".book-action .btn-positive").click
end

step "I return the book" do
  first(".btn-negative").click
end

step "I fill the review form" do
  within('.review-form') do
    fill_in 'review_body', with: 'Nice!'
  end
end

step "I search a book by its title" do
  @book = @books.last
  within '.search-form' do
    fill_in 'search_box', with: @books.last.title
  end
end

step "I search a book by its author" do
  @book = @books.last
  within '.search-form' do
    fill_in 'search_box', with: @book.authors
  end
end

step "I search for that word" do
  within '.search-form' do
    fill_in 'search_box', with: @title
  end
end

step "I should see the book listed" do
  expect(page).to have_content @book.title
end

step "I should see a list of all books" do
  @books.each do |book|
    expect(page).to have_content book.title
  end
end

step "I should see that there are no books" do
  expect(page).not_to have_css '.gallery .book'
end

step "I should see that the title has changed" do
  expect(page).to have_content @new_title
end

step "I should see the book's details" do
  expect(page).to have_content @book.title
end

step "that I am the book's owner" do
  expect(page).to have_content @book.owner
end

step "a button to download the ebook" do
  expect(page).to have_css "[href='#{@book.ebook}']"
  expect(page).not_to have_content I18n.t('books.actions.borrow')
end

step "I see that the book was borrowed by me" do
  expect(page).to have_content I18n.t('books.actions.return')
end

step "I see that the book is available for borrowing" do
  expect(page).to have_content I18n.t('books.actions.borrow')
end

step "I should be redirected to the review page" do
  expect(current_path).to eq review_book_path(@book.id)
end

step "I can't see a return button" do
  expect(page).not_to have_content I18n.t('books.actions.return')
end

step "I should see an empty search results message" do
  expect(page).not_to have_css ".gallery li"
end

step "I should see the read books list" do
  expect(page).to have_content @read_book.title
end

step "I should see my new review" do
  expect(page).to have_content @book.last_review_by(@user).body
end
