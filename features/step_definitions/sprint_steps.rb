Given /^I have created sprint "([^"]*)"$/ do |name|
  project = Project.first(:conditions => {:name => "x"})
  visit new_project_sprint_path(project)
  fill_in("Name", :with => name)
  click_button("Create Sprint")
end

