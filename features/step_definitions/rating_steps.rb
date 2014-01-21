When(/^I rate the book with (\d) stars$/) do |value|
  @rating = value
  choose("rating_#{value}")
end

Then(/^I see my rating$/) do
  within('.rating-form') do
    find_field("rating_#{@rating}").should be_checked
  end
end

Then(/^I see that the book's average rating was updated$/) do
  label = page.first('.book-info .rating .rating-label')
  label[:title].should match /#{@rating.to_f}/
end
