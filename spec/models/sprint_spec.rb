require 'spec_helper'

describe Sprint do
  before(:each) do
    @p = Project.create
  end

  subject do
    @p.sprints.create
  end

  it "requires a name" do
    subject.errors[:name].should include("can't be blank")
  end

  it "requires a start date" do
    subject.errors[:start_date].should include("can't be blank")
  end

  it "requires a end date" do
    subject.errors[:end_date].should include("can't be blank")
  end
  
  it "can give the total work days" do
    s = @p.sprints.create(
      :start_date => Date.new(2011, 03, 07),
      :end_date => Date.new(2011, 03, 25),
      :name => "My test sprint")

#    s.total_work_days.count.should == 15
# wtf happened to rang.count?
    
    (s.start_date..s.end_date).count.should == 15
  end
  
  it "can give the remaining work days" do
    s = @p.sprints.create(:start_date => Date.new(2011, 03, 07), :end_date => Date.new(2011, 03, 25), :name => "My test sprint")
    on_date = Date.new(2011, 03, 17)
    s.remaining_work_days(on_date).count.should == 6
  end
  
  it "can give the spent work days" do
    s = @p.sprints.create(:start_date => Date.new(2011, 03, 07), :end_date => Date.new(2011, 03, 25), :name => "My test sprint")
    on_date = Date.new(2011, 03, 17)
    s.spent_work_days(on_date).count.should == 9
  end
  
  describe "with stories" do
    before(:each) do
      @sprint = @p.sprints.create(:start_date => Date.new(2011, 03, 07), :end_date => Date.new(2011, 03, 25), :name => "My test sprint")
      @sprint.stories.create(:name => "Story 1", :points => 2, :status => "open")
      @sprint.stories.create(:name => "Story 2", :points => 1, :status => "active")
      @story = @sprint.stories.create(:name => "Story 3", :points => 5)
    end
    
    it "can give the total story points" do
      @sprint.total_story_points.should == 8
    end
      
    it "can give the total done story points on a given date" do
      date = Date.new(2011, 03, 18)
      @story.status = "done"
      @story.done_date = date
      @story.save
      @sprint.done_story_points_on(date).should == 5
    end

    it "does not give total done story points for a different date than the given date" do
      date = Date.new(2011, 03, 17)
      @story.status = "done"
      @story.done_date = Date.new(2011, 03, 18)
      @story.save
      @sprint.done_story_points_on(date).should == 0
    end
    
    it "can give the total open story points" do
      @story.status = "done"
      @story.done_date = Date.new(2011, 03, 17)
      @story.save
      @sprint.open_story_points.should == 3
    end

    describe "#done_story_points_per_workday" do
      it "returns a nested array of story points per day" do
        @sprint = @p.sprints.create(:start_date => Date.new(2011, 03, 07), :end_date => Date.new(2011, 03, 11), :name => "My test sprint")

        expected = [[0, 0], [1, 0], [2, 0], [3, 0], [4, 0]]

        @sprint.done_story_points_per_workday.should == expected
      end
    end
  end
end
