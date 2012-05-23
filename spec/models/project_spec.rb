require 'spec_helper'

describe Project do
  it "should have no stories" do
    subject.stories.should == []
  end
  it "should have no sprints" do
    subject.sprints.should == []
  end

  context "validations " do
    describe "#name" do
      it "should not allow an empty name" do
        [nil, "", " "].each do |invalid_title|
          subject.name = invalid_title
          subject.valid?.should be_false
        end
      end
      it "should allow a non empty name" do
        subject.name = "project"
        subject.valid?.should be_true
      end
    end
  end

  describe "#add_story" do
    it "should add the story to the project" do
      story = Story.new
      subject.add_story(story)
      subject.stories.should include(story)
    end
  end

  describe "#add_sprint" do
    it "should add the sprint to the project" do
      sprint = Sprint.new
      subject.add_sprint(sprint)
      subject.sprints.should include(sprint)
    end
  end

  describe "#backlog" do
    it "should return all stories not currently in a sprint" do
      project = Project.create(name: "My project")

      story1 = Story.create(:title => "story 1", :body => "Do stuff", :points => 1, :status => Status::OPEN, :project => project)
      story2 = Story.create(:title => "story 2", :body => "Do more", :points => 2, :status => Status::OPEN, :project => project)
      project.add_story(story1)
      project.add_story(story2)

      sprint = Sprint.create(project: project, title: "My Sprint")
      project.add_sprint(sprint)

      sprint.add_story(story1)
      sprint.save!

      project.backlog.should eq([story2])
    end
  end

end
