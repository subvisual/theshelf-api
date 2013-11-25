Given(/^I am a registered user$/) do
  step "I have an account on the system"
end

Given(/^I have an account on the system$/) do
  @user ||= create :user
  visit sign_in_path
  fill_in 'session_email', with: @user.email
  fill_in 'session_password', with: @user.password
  click_on I18n.t('helpers.submit.session.submit')
end

Given(/^I am a visitor$/) do
end

Given(/^there are(?: )?(available|lent)? books$/) do |status|
  status ||= "available"
  books_with_status = create_list(:book, 2).map {|book| book.public_send("make_#{status}".to_sym)}
  @books = BookDecorator.decorate_collection(books_with_status)
end

Given(/^there are no books$/) do
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
  within(".form__body") do
    fill_in 'book_title', with: @book.title
    fill_in 'book_authors', with: @book.authors
  end
end

When(/^I borrow the book$/) do
  find(".book-info .borrow").click
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
  page.should have_css ".borrowed", text: @user.decorate.name
end

