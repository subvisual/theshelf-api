When(/^I change my first name$/) do
  @user ||= build(:user)
  within("form") do
    fill_in 'user_first_name', with: @user.first_name
  end
end

When(/^I submit the new details$/) do
  first(".form-actions .btn-positive").click
end

Then(/^I should see my new name$/) do
  page.should have_content @user.decorate.name
end
