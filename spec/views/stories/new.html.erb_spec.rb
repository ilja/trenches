require 'spec_helper'

describe "stories/new.html.erb" do
  before(:each) do
    assign(:story, stub_model(Story).as_new_record)
  end

  it "renders new story form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => stories_path, :method => "post" do
    end
  end
end
