require 'spec_helper'

describe SprintsHelper do
  describe "#total_work_days_ticks(sprint)" do
    it "should return the total work days as json array grouped like [workday_number, workday_date]" do
      sprint = stub :total_work_days => [Date.new(2011, 06, 03),Date.new(2011, 06, 06),Date.new(2011, 06, 07)]      
      helper.total_work_days_ticks(sprint).should eq([[0,3],[1,6],[2,7]].to_json)
    end
  end
end