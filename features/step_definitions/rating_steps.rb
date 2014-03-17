Given(/^there are books rated by me$/) do
  @books = create_list(:rated_book, 1, rater: @user)
end

When(/^I rate the book with (\d) stars$/) do |value|
  rating = Rating.first || NullRating.new
  @rating_value = rating.value
  find(:xpath, "//label[@for='rating_#{value}']").click
end

When(/^I clear my rating$/) do
  @rating_value = @book.ratings.first.value
  page.execute_script('$("#my-rating").trigger("mouseenter")')
  find('#clear-rating').click
end

Then(/^I see that the book's average rating was updated$/) do
  title = page.first('.book-info .rating .rating-label')[:title]
  title.should_not match /#{@rating_value.to_f.to_s}/
end
