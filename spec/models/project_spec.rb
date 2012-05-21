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

end
