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
