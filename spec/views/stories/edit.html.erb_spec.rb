require 'spec_helper'

describe "stories/edit.html.erb" do
  before(:each) do
    @story = assign(:story, stub_model(Story))
  end

  it "renders the edit story form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => story_path(@story), :method => "post" do
    end
  end
end
