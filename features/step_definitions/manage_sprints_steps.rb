When /^I visit the project's sprints page$/ do
  steps %Q{
    When I go to my project's page
  }
  find(:xpath, "//a[@rel='sprints']").click
end

Then /^I should be able to add a new sprint$/ do
  find(:xpath, "//a[@rel='new-sprint']").click
  fill_in 'Title', :with => 'My new sprint'
  fill_in 'Goal', :with => 'World Domination'
  find(:xpath, "//input[@rel='save-sprint']").click
  within("#sprintlist") do
    page.should have_content 'My new sprint'
  end
end

Given /^I have added a sprint$/ do
  steps %Q{
    When I visit the project's sprints page
    Then I should be able to add a new sprint
  }
end

Then /^I should be able to edit that sprint$/ do
  find(:xpath, "//a[@rel='edit-sprint']").click
  fill_in 'Title', :with => 'My edited sprint'
  find(:xpath, "//input[@rel='save-sprint']").click
  within("#sprintlist") do
    page.should have_content 'My edited sprint'
    page.should_not have_content 'My new sprint'
  end
end

Then /^I should be able to delete that sprint$/ do
  find(:xpath, "//a[@rel='delete-sprint nofollow']").click
  page.should have_content 'Sprint deleted'
end

Then /^I should be able to go to that sprint's page$/ do
  click_link 'My new sprint'
  page.should have_content 'My new sprint'
  page.should have_content 'World Domination'
end

Then /^I should be able to visit that sprint's planning page$/ do
  steps %Q{
    When I visit the project's sprints page
    Then I should be able to go to that sprint's page
  }
  find(:xpath, "//a[@rel='sprint-planning']").click
  page.should have_content 'My new sprint / Planning'
end

Given /^I have added a story to that sprint$/ do
  steps %Q{
    When I visit the project's backlog page
    Then I should be able to add a new story
  }
  story = Story.first
  sprint = Sprint.first
  sprint.add_story(story)
  sprint.save!
end

Then /^I should be able to see that story on the sprint's page$/ do
  steps %Q{
    Given I am on the sprint's page
  }
  page.should have_content 'My new story'
end
