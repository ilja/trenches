require 'spec_helper'

describe "sprints/new.html.erb" do
  before(:each) do
    assign(:sprint, stub_model(Sprint,
      :name => "MyString",
      :project => nil
    ).as_new_record)
  end

  it "renders new sprint form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => sprints_path, :method => "post" do
      assert_select "input#sprint_name", :name => "sprint[name]"
      assert_select "input#sprint_project", :name => "sprint[project]"
    end
  end
end
