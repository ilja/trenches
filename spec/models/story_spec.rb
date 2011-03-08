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
      user = User.new
      @story.start(user)
      @story.assigned_to.should == user
    end
  end
end
