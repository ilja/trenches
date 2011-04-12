require 'spec_helper'

describe Project do
  describe "#backlog" do
    it "should return all stories that are not in a sprint" do
      @project = Factory.create(:project)
      @sprint = Factory.create(:sprint, :project => @project)
      @story1 = Factory.create(:story, :name => 'first', :project => @project, :sprint => @sprint)
      @story2 = Factory.create(:story, :name => 'second',  :project => @project)
      @project.backlog.all.should include @story2
      @project.backlog.all.should_not include @story1
    end
  end
  describe "#active_sprint_for(user)" do
    before :each do
      @project = Factory.create(:project)
      @sprint1 = Factory.create(:sprint, :project => @project)
      @sprint2 = Factory.create(:sprint, :project => @project)
      @user = Factory.create(:user)
    end
    it "should return the active sprint for the given user" do
      @user.assign_active_sprint(@sprint2)
      @project.active_sprint_for(@user).should == @sprint2
    end
    it "should not return a sprint if no active sprint is set for the given user" do
      @project.active_sprint_for(@user).should be_nil
    end
  end
end
