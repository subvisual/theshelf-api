step "there are books rated by me" do
  @books = create_list(:rated_book, 1, rater: @user)
end

step "I rate the book with :value stars" do |value|
  rating = Rating.first || NullRating.new
  @rating_value = rating.value
  find(:xpath, "//label[@for='rating_#{value}']").click
end

step "I clear my rating" do
  @rating_value = @book.ratings.first.value
  page.execute_script('$("#my-rating").trigger("mouseenter")')
  find('#clear-rating').click
end

step "I see that the book's average rating was updated" do
  expect(page.first('.book-info .rating .rating-label')[:title]).not_to match /#{@rating_value.to_f.to_s}/
end
