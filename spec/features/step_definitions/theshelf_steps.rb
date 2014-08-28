step "I have an account on the system" do
  @user ||= create :user
  visit root_path as: @user
end

step "I am a visitor" do
end

step "I am/go on/to the sign up page" do
  visit sign_up_path
end

step "I am/go on/to the shelf page" do
  visit books_path
end

step "I am on the add a book page" do
  visit new_book_path()
end

step "I am/go on/to a book's page" do
  @book = @books.find{ |book| book.available? }
  visit book_path(@book.id)
end

step "I am/go on/to a borrowed book's page" do
  visit book_path(@book.id)
end

step "I am/go on/to the edit account page" do
  visit my_account_path
end

step "I go to a book's edit page" do
  visit edit_book_path(@books.first.id)
end

step "I reload the page" do
  visit(current_path)
end

step "I should be redirected to the sign in page" do
  expect(current_path).to eq log_in_path
end
