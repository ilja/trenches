Given /^story "([^"]*)" exists in the backlog of project "([^"]*)"$/ do |story_name, project_name|
  project = Project.create!(:name => project_name)
  story = Story.create!(:name => story_name, :message => 'the message')
  project.stories << story
  project.save
end
