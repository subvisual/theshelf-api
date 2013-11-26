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

When(/^I borrow an available book$/) do
  first("#books .available .borrow").click
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
  within(".form") do
    fill_in 'book_title', with: @book.title
    fill_in 'book_authors', with: @book.authors
  end
end

When(/^I borrow the book$/) do
  find(".book-info .borrow").click
end

When(/^I return the book$/) do
  first(".return").click
end

Then(/^I should see a list of all books$/) do
  @books.each do |book|
    page.should have_content book.title
  end
end

Then(/^I should see that there are no books$/) do
  page.should have_content I18n.t('books.empty')
end

Then(/^I should see that the title has changed$/) do
  page.should have_content @new_title
end

Then(/^I should see the book's details$/) do
  page.should have_content @book.title
end

Then(/^I see that the book was borrowed by me$/) do
  page.should have_css ".return"
end

Then(/^I see that the book is available for borrowing$/) do
  page.should have_css ".available"
end

Then(/^I can't see a return button$/) do
  page.should_not have_css ".return"
end
