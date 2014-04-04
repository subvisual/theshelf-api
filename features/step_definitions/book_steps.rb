Given(/^there are(?: available)? books$/) do
  @books = BookDecorator.decorate_collection(create_list(:available_book, 2))
end

Given(/^there are no books borrowed by me$/) do
  @books = [create(:lent_book, borrower: create(:user))]
end

Given(/^there are no books$/) do
end

Given(/^I've borrowed a book$/) do
  @book = create(:lent_book, borrower: @user).decorate
end

Given(/^there isn't a book with title (\w+)/) do |title|
  @title = title
  page.should_not have_content title
end

When(/^I borrow an available book$/) do
  within '#book-list' do
    first('.btn-positive').click
  end
end

When(/^I change the book's title$/) do
  @new_title = "Random title"
  fill_in 'book_title', with: @new_title
end

When(/^I submit the book$/) do
  click_on I18n.t('books.submit')
end

When(/^I fill the new book form$/) do
  @book ||= build(:book)
  within("form") do
    fill_in 'book_title', with: @book.title
    fill_in 'book_authors', with: @book.authors
  end
end

When(/^add myself as the book's owner$/) do
  @book.owner = "King Arthur"
  within("form") do
    fill_in 'book_owner', with: @book.owner
  end
end

When(/^I borrow the book$/) do
  first(".book-action .btn-positive").click
end

When(/^I return the book$/) do
  first(".btn-negative").click
end

When(/^I fill the review form$/) do
  within('.review-form') do
    fill_in 'review_body', with: 'Nice!'
  end
end

When(/^I submit the review$/) do
  find(".review-form .btn-positive").click
end

Then(/^I should see my new review$/) do
  page.should have_content @book.last_review_by(@user).body
end

When(/^I search a book by its title$/) do
  @book = @books.last
  within '.search-form' do
    fill_in 'search_box', with: @books.last.title
  end
end

When(/^I search a book by its author$/) do
  @book = @books.last
  within '.search-form' do
    fill_in 'search_box', with: @book.authors
  end
end

When(/^I search for that word/) do
  within '.search-form' do
    fill_in 'search_box', with: @title
  end
end

Then(/^I should see the book listed$/) do
  page.should have_content @book.title
end

Then(/^I should see a list of all books$/) do
  @books.each do |book|
    page.should have_content book.title
  end
end

Then(/^I should see that there are no books$/) do
  page.should_not have_css '.gallery .book'
end

Then(/^I should see that the title has changed$/) do
  page.should have_content @new_title
end

Then(/^I should see the book's details$/) do
  page.should have_content @book.title
end

Then(/^that I am the book's owner$/) do
  page.should have_content @book.owner
end

Then(/^I see that the book was borrowed by me$/) do
  page.should have_css ".btn-negative"
end

Then(/^I see that the book is available for borrowing$/) do
  page.should have_css ".btn-positive"
end

Then(/^I can't see a return button$/) do
  page.should_not have_css ".btn-negative"
end

Then(/^I should see an empty search results message$/) do
  page.should_not have_css ".gallery li"
end
