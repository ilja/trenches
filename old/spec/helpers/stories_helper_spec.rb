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
    describe "when in a sprint" do
      before(:each) do
        @p = Factory.create(:project)
        @s = @p.sprints.create(
          :start_date => Date.new(2011, 03, 07),
          :end_date => Date.new(2011, 03, 25),
          :name => "My test sprint")
      end
      it "doesn't render a link if the story points are unknown" do
        story = Factory.create(:story, :points =>  StoryPoint::UNKNOWN)
        helper.change_status_button(story).should == ""
      end
      it "does not prepend '| ' if the status is 'done'" do
        story = Factory.create(:story, :points =>  StoryPoint::TWO, :status => "done")
        helper.change_status_button(story).should == ""
      end
      it "renders a link to start the story if the status is 'open'" do
        story = Factory.create(:story, :points =>  StoryPoint::TWO, :status => "open", :project => @p, :sprint => @s)
        expected = "<a href=\"/projects/#{@p.id}/stories/#{story.id}/start\" class=\"button\">Start</a>"
        helper.change_status_button(story).should == expected
      end
      it "renders a link to mark the story as done if the status is 'active'" do
        story = Factory.create(:story, :points =>  StoryPoint::TWO, :status => "active", :project => @p, :sprint => @s)
        expected = "<a href=\"/projects/#{@p.id}/stories/#{story.id}/finish\" class=\"button\">Done</a>"
        helper.change_status_button(story).should == expected
      end
    end
    it "doesn't render a link if the story is not in a sprint" do
      story = Factory.create(:story, :points =>  StoryPoint::TWO)
      helper.change_status_button(story).should == ""
    end
  end

  describe "#sort_button" do
    it "renders links for own filter if no filters active" do
      params = []
      expected = "<a href='?show%5B%5D=open' class='button'>Open</a>" +
        "<a href='?show%5B%5D=active' class='button'>In progress</a>" +
        "<a href='?show%5B%5D=done' class='button'>Done</a>"
      helper.sort_button(params).should == expected
    end
    it "renders a link with other active filters" do
      params = ["open"]
      expected = "<a href='?' class='button active'>Open</a>" +
        "<a href='?show%5B%5D=open&show%5B%5D=active' class='button'>In progress</a>" +
        "<a href='?show%5B%5D=open&show%5B%5D=done' class='button'>Done</a>"
      helper.sort_button(params).should == expected
    end
    it "renders a link with multiple active filters" do
      params = ["open", "done"]
      expected = "<a href='?show%5B%5D=done' class='button active'>Open</a>" +
        "<a href='?show%5B%5D=open&show%5B%5D=done&show%5B%5D=active' class='button'>In progress</a>" +
        "<a href='?show%5B%5D=open' class='button active'>Done</a>"
      helper.sort_button(params).should == expected
    end
  end
end
