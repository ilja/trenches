require 'spec_helper'

describe Sprint do
  subject do
    p = Project.create
    p.sprints.create
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
end
