require 'spec_helper'

describe Story do
  describe ".start" do
    before(:each) do
      @story = Story.create(:name => "test story")
    end

    it "changes status to active" do
      @story.status.should == "open"
      @story.start(User.new)
      @story.status.should == "active"
    end

    it "sets the assigned user" do
      @story.assigned_to.should be_nil
      user = User.create(:name => "bob")
      @story.start(user)
      @story.assigned_to.should == user
      @story.assigned_to.name.should == "bob"
    end
  end

  describe ".finish" do
    before(:each) do
      @story = Story.create(:name => "test story")
      @user = User.new
      @story.start(@user)
    end
    it "changes status to done" do      
      @story.status.should == "active"
      @story.finish(@user)
      @story.status.should == "done"
    end
    it "sets the done_date" do
      @story.done_date.should be_nil
      @story.finish(@user)
      @story.done_date.should_not be_nil
    end
  end
end
