Given /^I am on the sprint's page$/ do
 steps %Q{
    When I visit the project's sprints page
    Then I should be able to go to that sprint's page
  }
end

Then /^I should be able to start the story$/ do
  page.should have_content 'My new story'
  find(:xpath, "//a[@rel='start-story']").click
  page.should have_content 'My new story (bob)'

end
