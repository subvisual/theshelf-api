Given(/^I am a user$/) do
end

When(/^I go to the book's index$/) do
  visit books_path
end

When(/^I go to the book's page$/) do
  visit book_path(@book.id)
end

When(/^I go to the book's edit page$/) do
  visit edit_book_path(@book.id)
end

Given(/^I am on the add a book page$/) do
  visit new_book_path()
end
