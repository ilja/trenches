require 'spec_helper'

describe Story do
  describe ".start" do
    before(:each) do
      @story = Factory.create(:story, :name => "test story")
    end

    it "changes status to active" do
      @story.status.should == "open"
      @story.start(User.new)
      @story.status.should == "active"
    end

    it "sets the assigned user" do
      @story.assigned_to.should be_nil
      user = Factory.create(:user, :name => "bob")
      @story.start(user)
      @story.assigned_to.should == user
      @story.assigned_to.name.should == "bob"
    end
  end

  describe ".finish" do
    before(:each) do
      @story = Factory.create(:story, :name => "test story")
      @user = Factory.create(:user)
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
