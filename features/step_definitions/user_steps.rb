When(/^I change my first name$/) do
  @user ||= build(:user)
  within("form") do
    fill_in 'user_first_name', with: @user.first_name
  end
end

When(/^I fill in the sign up form$/) do
  @user ||= build(:user)
  within("form") do
    fill_in 'user_first_name', with: @user.first_name
    fill_in 'user_last_name', with: @user.last_name
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user.password
  end
end

When(/^I sign up$/) do
  find('.btn-positive').click
end

When(/^I submit the new details$/) do
  first(".form-actions .btn-positive").click
end

Then(/^I should see my new name$/) do
  page.should have_content @user.decorate.name
end

Then(/^I should be redirected to the shelf page$/) do
  current_path.should eq root_path
end
