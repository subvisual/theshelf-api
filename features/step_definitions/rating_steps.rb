When(/^I rate the book with (\d) stars$/) do |value|
  @rating = value
  find(:xpath, "//label[@for='rating_#{value}']").click
end

Then(/^I see that the book's average rating was updated$/) do
  label = page.first('.book-info .rating .rating-label')
  label[:title].should match /#{@rating.to_f}/
end
