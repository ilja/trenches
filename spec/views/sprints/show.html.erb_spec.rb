require 'spec_helper'

describe "sprints/show.html.erb" do
  before(:each) do
    @sprint = assign(:sprint, stub_model(Sprint,
      :name => "Name",
      :project => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
  end
end
