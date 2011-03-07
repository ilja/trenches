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
    s = @p.sprints.create(:start_date => Date.new(2011, 03, 07), :end_date => Date.new(2011, 03, 25), :name => "My test sprint")    
    s.total_work_days.count.should == 15
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
      @story.status = "done"
      @story.save
      on_date = Date.new(2011, 03, 17) #todo: set done date when marking story as done
      @sprint.done_story_points(on_date).should == 5
    end
    
    it "can give the total open story points on a given date" do
      @story.status = "done"
      @story.save
      on_date = Date.new(2011, 03, 17) #todo: set done date when marking story as done
      @sprint.open_story_points(on_date).should == 3
    end
  end
end
