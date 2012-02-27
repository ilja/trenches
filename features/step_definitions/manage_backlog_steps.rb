When /^I go to my project's page$/ do
  click_link 'My new projec'
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
  fill_in 'Name', :with => 'My new story'
  find(:xpath, "//input[@rel='save-story']").click
  page.should have_content 'My new story'
end

