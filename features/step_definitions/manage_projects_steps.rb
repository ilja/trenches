When /^I go to my projects page$/ do
  find(:xpath, "//a[@rel='my-projects']").click
end

When /^I create a new project$/ do
  find(:xpath, "//a[@rel='new-project']").click
  fill_in 'Name', :with => 'My new project'
  find(:xpath, "//input[@rel='save-project']").click
end

Then /^I should see my new project$/ do
  page.should have_content 'My new project'
end

Given /^I have created a project$/ do
  steps %Q{
    When I go to my projects page
    When I create a new project
  }
end

Then /^I should be able to view my project$/ do
  click_link 'My new project'
  page.should have_content 'My new project'
end

Then /^I should be able to change my project$/ do
  find(:xpath, "//a[@rel='edit-project']").click
  fill_in 'Name', :with => 'My changed project'
  find(:xpath, "//input[@rel='save-project']").click
  page.should have_content 'My changed project'
end

Then /^I should be able to delete my project$/ do
  #find(:xpath, "//a[@rel='delete-project']").click
  click_link 'Destroy'
  page.should_not have_content 'My project'
end

Then /^I should be able to add members$/ do
  FactoryGirl.create(:user, :username => 'joe')
  click_link 'My new project'
  find(:xpath, "//a[@rel='add-members']").click
  fill_in 'Username', :with => 'joe'
  find(:xpath, "//input[@rel='add-member']").click
  page.should have_content 'joe'
end

