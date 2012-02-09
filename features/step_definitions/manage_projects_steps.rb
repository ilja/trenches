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
