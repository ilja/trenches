require 'active_model'
require_relative '../../app/models/project'
require 'ostruct'
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

  describe "#new_story" do
    before(:each) do
      @new_story = Story.new
      subject.story_maker = -> { @new_story }
    end
    it "should return a new story" do
      subject.new_story.should == @new_story
    end
    it "should set the story's project reference to itself" do
      subject.new_story.project.should == subject
    end
    it "should accept an attribute hash on behalf of the story maker" do
      story_maker = double()
      story_maker.should_receive(:call).with({:x => 42, :y => 'z'}) { @new_story }
      subject.story_maker = story_maker
      subject.new_story(:x => 42, :y => 'z')
    end
  end
  describe "#add_story" do
    it "should add the story to the project" do
      story = Story.new
      subject.add_story(story)
      subject.stories.should include(story)
    end
  end
  describe "#new_sprint" do
    before(:each) do
      @new_sprint = OpenStruct.new
      subject.sprint_maker = -> { @new_sprint }
    end
    it "should return a new sprint" do
      subject.new_sprint.should == @new_sprint
    end
    it "should set the sprint's project reference to itself" do
      subject.new_sprint.project.should == subject
    end
    it "should accept an attribute hash on behalf of the sprint maker" do
      sprint_maker = double()
      sprint_maker.should_receive(:call).with({:x => 42, :y => 'z'}) { @new_sprint }
      subject.sprint_maker = sprint_maker
      subject.new_sprint(:x => 42, :y => 'z')
    end
  end

end
