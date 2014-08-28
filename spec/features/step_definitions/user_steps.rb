step "I change my first name" do
  @user ||= build(:user)
  within('form') do
    fill_in 'user_first_name', with: @user.first_name
  end
end

step "I fill in the sign up form" do
  @user ||= build(:user)
  within('form') do
    fill_in 'user_first_name', with: @user.first_name
    fill_in 'user_last_name', with: @user.last_name
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user.password
  end
end

step "I sign up" do
  find('.btn-positive').click
end

step "I submit the new details" do
  first(".form-actions .btn-positive").click
end

step "I should see my new name" do
  expect(page).to have_content @user.decorate.name
end

step "I should be redirected to the shelf page" do
  expect(current_path).to eq root_path
end
