When(/^I go to the book's index$/) do
  visit books_path
end

Given(/^I (?:am on|go to) the shelf page$/) do
  visit books_path
end

Given(/^I am on the add a book page$/) do
  visit new_book_path()
end

Given(/^I (?:am on|go to) (?:a|an available) book's page$/) do
  @book = @books.map{ |book| book if book.available? }.first
  visit book_path(@book.id)
end

When(/^I go to a book's edit page$/) do
  visit edit_book_path(@books.first.id)
end

Then(/^I should be redirected to the sign in page$/) do
  current_path.should eq sign_in_path
end
