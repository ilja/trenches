Given /^I am on the home page$/ do
  visit root_url
end

When /^I choose to sign up for an account$/ do
  find(:xpath, "//a[@rel='signup']").click
  fill_in 'Username', :with => 'bob'
  fill_in 'Email', :with => 'bob@example.com'
  fill_in 'Password', :with => 'secret'
  fill_in 'Password confirmation', :with => 'secret'
  click_button 'Create my account'
end

Then /^my account should be created$/ do
  page.should have_content 'Thank you for registering! You can now log in!'
end

Given /^I have registered an account$/ do
  visit root_url
  step "I choose to sign up for an account"
end

When /^I sign in$/ do
  find(:xpath, "//a[@rel='login']").click
  fill_in 'Username', :with => 'bob'
  fill_in 'Password', :with => 'secret'
  find(:xpath, "//input[@rel='new-session']").click
end

Then /^I should be signed in$/ do
  page.should have_content 'Nice Work! You are now logged in!'
end

Then /^I should see a message that I am not registered$/ do
  page.should have_content 'Sorry, Email or password was invalid.'
end

Given /^I am logged in$/ do
  visit root_url
  step "I choose to sign up for an account"
  step "I sign in"
end

When /^I sign out$/ do
  find(:xpath, "//a[@rel='logout']").click
end

Then /^I should be signed out$/ do
  page.should have_content 'Logged out'
end
