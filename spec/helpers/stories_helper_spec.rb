require 'spec_helper'

describe StoriesHelper do
  describe "#link_to_story_developer" do
    it "prints the name of the associated developer" do
      user = Factory.create(:user, :name => "bob")
    	
      story = stub :assigned_to => user
      helper.link_to_story_developer(story).should == "(bob)"
    end
  end
  describe "#change_status_button" do
  	it "doesn't render a link if the story points are unknown" do
  	  story = Factory.create(:story, :points =>  StoryPoint::UNKNOWN)
  	  helper.change_status_button(story).should == ""
  	end
  	it "does not prepend '| ' if the status is 'done'" do
  	  story = Factory.create(:story, :points =>  StoryPoint::TWO, :status => "done")
  	  helper.change_status_button(story).should == ""
  	end
  	it "renders a link to start the story if the status is 'open'" do
  	  project = Factory.create(:project)
  	  story = Factory.create(:story, :points =>  StoryPoint::TWO, :status => "open", :project => project)
  	  expected = "| <a href=\"/projects/#{project.id}/stories/#{story.id}/start\">Start</a>"
  	  helper.change_status_button(story).should == expected
  	end
  	it "renders a link to mark the story as done if the status is 'active'" do
  	  project = Factory.create(:project)
  	  story = Factory.create(:story, :points =>  StoryPoint::TWO, :status => "active", :project => project)
  	  expected = "| <a href=\"/projects/#{project.id}/stories/#{story.id}/finish\">Done</a>"
  	  helper.change_status_button(story).should == expected
  	end
  end
end