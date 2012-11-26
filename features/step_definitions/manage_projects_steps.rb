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
  click_on 'My new project'
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
  click_on 'Destroy'
  page.should_not have_content 'My project'
end

Then /^I should be able to add members$/ do
  FactoryGirl.create(:user, :username => 'joe')
  click_on 'My new project'
  find(:xpath, "//a[@rel='manage-project']").click
  find(:xpath, "//a[@rel='manage-members']").click
  fill_in 'Username', :with => 'joe'
  find(:xpath, "//input[@rel='add-member']").click
  page.should have_content 'joe'
end

Given /^I have added other members$/ do
  steps %Q{
    When I go to my projects page
    And I should be able to add members
  }
end

Then /^I should be able to remove members$/ do
  within(:xpath, "//li[contains(child::text(),'joe')]") do
    page.should have_content 'joe'
    find(:xpath, "//li[contains(child::text(),'joe')]/a[contains(@rel,'remove-member')]").click
  end
  page.should have_content 'joe is no longer a member of this project'
end

