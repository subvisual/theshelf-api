Given(/^I am a registered user$/) do
  user = create :user
  visit sign_in_path
  fill_in 'session_email', with: user.email
  fill_in 'session_password', with: user.password
  click_on I18n.t('helpers.submit.session.submit')
end

Given(/^I am a visitor$/) do
end

Given(/^there are books$/) do
  @books = BookDecorator.decorate_collection create_list(:book, 2)
end

Then(/^I should see a list of all books$/) do
  @books.each do |book|
    page.should have_content book.title
  end
end

Given(/^there are no books$/) do
end

Then(/^I should see that there are no books$/) do
  page.should have_content I18n.t('books.empty')
end

Given(/^there is a book$/) do
  @book = BookDecorator.decorate create(:book)
end

Then(/^I should see the book's details$/) do
  page.should have_content @book.title
end

When(/^I change the book's title$/) do
  @new_title = "Random title"
  fill_in 'book_title', with: @new_title
end

When(/^I submit the book$/) do
  click_on I18n.t('books.submit')
end

Then(/^I should see that the title has changed$/) do
  page.should have_content @new_title
end

When(/^I fill the new book form$/) do
  @book ||= build(:book)
  within(".form__body") do
    fill_in 'book_title', with: @book.title
    fill_in 'book_authors', with: @book.authors
  end
end
