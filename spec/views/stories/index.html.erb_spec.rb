require 'spec_helper'

describe "stories/index.html.erb" do
  before(:each) do
    assign(:stories, [
      stub_model(Story),
      stub_model(Story)
    ])
  end

  it "renders a list of stories" do
    render
  end
end
