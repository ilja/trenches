require 'spec_helper'

describe Story do
   it "should start with blank attributes" do
    subject.title.should be_nil
    subject.body.should be_nil
  end

  it "should support reading and writing a title" do
    subject.title = "foo"
    subject.title.should == "foo"
  end

  it "should support reading and writing a story body" do
    subject.body = "foo"
    subject.body.should == "foo"
  end

  it "should support reading and writing story points" do
    subject.points = 2
    subject.points.should == 2
  end

  it "should support reading and writing the story's status" do
    subject.status = Status::DONE
    subject.status.should == Status::DONE
  end

  it "should support reading and writing a project reference" do
    project = Project.new
    subject.project = project
    subject.project.should == project
  end

  it "should support setting attributes in the initializer" do
    subject = Story.new(:title => "mytitle", :body => "mybody")
    subject.title.should == "mytitle"
    subject.body.should == "mybody"
  end

  context "validations " do
    describe "#title" do
      before(:each) do
        subject.stub(:project_id) { 666 }
      end
      it "should not allow an empty title" do
        [nil, "", " "].each do |title|
          subject.title = title
          subject.valid?.should be_false
        end
      end
      it "should allow a non empty title" do
        subject.title = "a"
        subject.valid?.should be_true
      end
    end
    describe "#project" do
      before do
        subject.title = "x"
      end
      it "should not allow an empty project" do
        subject.project = nil
        subject.valid?.should be_false
        subject.errors[:project_id].should include("can't be blank")
      end
    end
  end

  describe "#publish" do
    before do
      @project = Project.new
      subject.stub(:project) { @project }
    end
    it "should add the story to the project" do
      @project.should_receive(:add_story).with(subject)
      subject.publish
    end
  end
end
