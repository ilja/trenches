Given /^I have created project "([^"]*)"$/ do |name|
  visit new_project_path
  fill_in("Name", :with => name)
  click_button("Create Project")
end

Then /^I should have no projects$/ do
  Story.all.count == 0
end
