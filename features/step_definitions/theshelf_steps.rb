Given(/^I have an account on the system$/) do
  @user ||= create :user
  visit root_path as: @user
end

Given(/^I am a visitor$/) do
end

Given(/^I (?:am on|go to) the sign up page$/) do
  visit sign_up_path
end

Given(/^I (?:am on|go to) the shelf page$/) do
  visit books_path
end

Given(/^I am on the add a book page$/) do
  visit new_book_path()
end

Given(/^I (?:am on|go to) (?:a|an available) book's page$/) do
  @book = @books.find{ |book| book.available? }
  visit book_path(@book.id)
end

Given(/^I (?:am on|go to) a borrowed book's page$/) do
  visit book_path(@book.id)
end

Given(/^I (?:am on|go to) the edit account page$/) do
  visit my_account_path
end

When(/^I reload the page$/) do
  visit(current_path)
end

When(/^I go to a book's edit page$/) do
  visit edit_book_path(@books.first.id)
end

Then(/^I should be redirected to the sign in page$/) do
  current_path.should eq log_in_path
end
