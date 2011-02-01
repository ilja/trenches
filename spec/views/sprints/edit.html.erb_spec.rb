require 'spec_helper'

describe "sprints/edit.html.erb" do
  before(:each) do
    @sprint = assign(:sprint, stub_model(Sprint,
      :name => "MyString",
      :project => nil
    ))
  end

  it "renders the edit sprint form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => sprint_path(@sprint), :method => "post" do
      assert_select "input#sprint_name", :name => "sprint[name]"
      assert_select "input#sprint_project", :name => "sprint[project]"
    end
  end
end
