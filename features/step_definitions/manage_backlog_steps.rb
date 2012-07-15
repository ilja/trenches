When /^I go to my project's page$/ do
  click_link 'My new project'
end

When /^I go to its backlog page$/ do
  find(:xpath, "//a[@rel='project-backlog']").click
end

Then /^I should see the product backlog$/ do
  page.should have_content 'Product Backlog'
end

When /^I visit the project's backlog page$/ do
  steps %Q{
    When I go to my project's page
    And I go to its backlog page
    Then I should see the product backlog
  }
end

Then /^I should be able to add a new story$/ do
  find(:xpath, "//a[@rel='new-story']").click
  fill_in 'Title', :with => 'My new story'
  find(:xpath, "//input[@rel='save-story']").click
  within("#storylist") do
    page.should have_content 'My new story'
  end
end

Given /^I have added a story$/ do
  steps %Q{
    When I visit the project's backlog page
    Then I should be able to add a new story
  }
end

Then /^I should be able to edit that story$/ do
  find(:xpath, "//a[@rel='edit-story']").click
  fill_in 'Title', :with => 'My edited story'
  find(:xpath, "//input[@rel='save-story']").click
  within("#storylist") do
    page.should have_content 'My edited story'
  end
end

Then /^I should be able to delete that story$/ do
  find(:xpath, "//a[@rel='edit-story']").click
  find(:xpath, "//a[@rel='delete-story nofollow']").click
  within("#storylist") do
    page.should_not have_content 'My new story'
  end
end

Given /^I have (\d+) backlog items$/ do |amount|
  project = Project.first
  amount.to_i.times do |i|
    Story.create(:title => "Story #{i}", :project => project)    
  end
end

Then /^I should see the top 10 backlog items$/ do
  page.should have_content 'Story 1'
  page.should have_content 'Story 9'
  page.should_not have_content 'Story 10'
end
