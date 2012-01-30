When /^I go to my projects page$/ do
  find(:xpath, "//a[@rel='my-projects']").click
end

When /^I create a new project$/ do
  find(:xpath, "//a[@rel='new-project']").click
end

Then /^I should see my new project$/ do
  pending # express the regexp above with the code you wish you had
end
