Given /^I have created project "([^"]*)"$/ do |name|
  visit new_project_path
  fill_in("Name", :with => name)
  click_button("Create Project")
end

Then /^I should have no projects$/ do
  Story.all.count == 0
end

Given /^project "([^"]*)" exists$/ do |name|
  Project.create(:name => name)
end

Given /^I visit the sprints page for project "([^"]*)"$/ do |name|
  project = Project.first(:conditions => {:name => name})
  visit project_sprints_path(project.id)
end

Given /^I visit the backlog page of project "([^"]*)"$/ do |name|
  project = Project.first(:conditions => {:name => name}) || Project.create!(:name => name) 
  visit backlog_path(project)
end

Then /^I should return to the backlog page of project "([^"]*)"$/ do |name|
  project = Project.first(:conditions => {:name => name})
  visit backlog_path(project)
end
