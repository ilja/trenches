require 'active_model'
require_relative '../../app/models/sprint'
require_relative '../../app/models/story'
require 'spec_helper'

describe Sprint do
  it "should start with blank attributes" do
    subject.title.should be_nil
    subject.goal.should be_nil
  end

  it "should have no stories" do
    subject.stories.should == []
  end

  it "should be 0% completed" do
    subject.percentage_completed.should == 0.0
  end

  context "validations" do
    before do
      subject.project = Object.new
    end
    describe "title" do
      it "should not allow an empty title" do
        [nil, "", " "].each do |invalid_title|
          subject.title = invalid_title
          subject.valid?.should be_false
        end
      end
      it "should allow a non empty title" do
        subject.title = "sprint"
        subject.valid?.should be_true
      end
    end
    describe "project" do
      it "should require a project" do
        subject.project = nil
        subject.valid?.should be_false
        subject.errors[:project].should include("can't be blank")
      end
    end
  end

  context "start and end dates" do
    before(:each) do
      @clock = double()
      @now = DateTime.parse("2011-09-11T02:56")
      @clock.stub(:now) { @now }
    end
    subject { Sprint.new(:clock => @clock) }

    it "should set the start date to today" do
      subject.start_date.should == @now
    end

    it "should set the end date to three weeks from today" do
      three_weeks_later = DateTime.parse("2011-10-02T02:56")
      subject.end_date.should == three_weeks_later
    end

    it "should calculate the total days" do
      subject.total_days.count.should == 22
    end

    it "should calculate the total work days" do
      subject.total_work_days.count.should == 15
    end

    it "should give the remaining work days on the given date" do
      on_date = DateTime.parse("2011-09-17T02:56")
      subject.remaining_work_days(on_date).count.should == 10
    end

    it "should give the spent work days on the given date" do
      on_date = DateTime.parse("2011-09-19T02:56")
      subject.spent_work_days(on_date).count.should == 6
    end
  end

  it "should support reading and writing a title" do
    subject.title = "foo"
    subject.title.should == "foo"
  end

  it "should support reading and writing a sprint goal" do
    subject.goal = "foo"
    subject.goal.should == "foo"
  end

  it "should support reading and writing a project reference" do
    project = Object.new
    subject.project = project
    subject.project.should == project
  end

  it "should support setting attributes in the initializer" do
    subject = Sprint.new(:title => "mytitle", :goal => "mygoal")
    subject.title.should == "mytitle"
    subject.goal.should == "mygoal"
  end

  describe "#define" do
    before do
      @project = double("Project")
      subject.project = @project
    end
    it "should add the sprint to the project" do
      @project.should_receive(:add_entry).with(subject)
      subject.define
    end
  end

  context "with stories" do
    before(:each) do
      subject.stories << Story.new(:title => "mytitle", :body => "mybody", :points => 1, :status => "open")
      subject.stories << Story.new(:title => "mytitle", :body => "mybody", :points => 2, :status => "open")
      subject.stories << Story.new(:title => "mytitle", :body => "mybody", :points => 5, :status => "done")
      subject.stories.count.should == 3
    end
    it "should calculate the total story points" do
      subject.total_story_points.should == 8
    end
    it "should calculate the total open story points" do
      subject.open_story_points.should == 3
    end
    it "should calculate the percentage completed" do
      subject.percentage_completed.should == 62.5
    end
  end
end
