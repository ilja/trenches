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
  FactoryGirl.create(:project, :name => "My project")
end

Then /^I should be able to view my project$/ do
  click_link 'My project'
  page.should have_content 'My project'
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

