require 'spec_helper'

describe "stories/show.html.erb" do
  before(:each) do
    @story = assign(:story, stub_model(Story))
  end

  it "renders attributes in <p>" do
    render
  end
end
