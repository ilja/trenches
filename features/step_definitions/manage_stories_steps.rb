Given /^I am on the sprint's page$/ do
 steps %Q{
    When I visit the project's sprints page
    Then I should be able to go to that sprint's page
  }
end

Then /^I should be able to start the story$/ do
  page.should have_content 'My new story'
  find(:xpath, "//a[@rel='start-story']").click
  page.should have_content 'Story started'
  page.should have_content 'My new story (bob)'
end

Given /^I have started a story$/ do
  step "I should be able to start the story"
  page.should_not have_content 'Start'
end

Then /^I should be able to finish it$/ do
  find(:xpath, "//a[@rel='finish-story']").click
  page.should have_content 'Story finished'
end
