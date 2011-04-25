require 'spec_helper'

describe User do

	it "can assign an active sprint" do
		user = User.create(:name => "bob")
		p = Project.create
    s = p.sprints.create(:start_date => Date.new(2011, 03, 07), :end_date => Date.new(2011, 03, 25), :name => "My test sprint")
    user.assign_active_sprint(s)

    user.active_sprint.should == s
  end

end
