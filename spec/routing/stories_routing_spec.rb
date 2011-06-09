require "spec_helper"

describe StoriesController do
  describe "routing" do    
    it "recognizes and generates #index" do
      { :get => "/projects/1/stories" }.should route_to(:controller => "stories", :action => "index", :project_id => "1")
    end
    it "recognizes and generates #new" do
      { :get => "/projects/1/stories/new" }.should route_to(:controller => "stories", :action => "new", :project_id => "1")
    end
    it "recognizes and generates #show" do
      { :get => "/projects/1/stories/1" }.should route_to(:controller => "stories", :action => "show", :id => "1", :project_id => "1")
    end
    it "recognizes and generates #edit" do
      { :get => "/projects/1/stories/1/edit" }.should route_to(:controller => "stories", :action => "edit", :id => "1", :project_id => "1")
    end
    it "recognizes and generates #create" do
      { :post => "/projects/1/stories" }.should route_to(:controller => "stories", :action => "create", :project_id => "1")
    end
    it "recognizes and generates #update" do
      { :put => "/projects/1/stories/1" }.should route_to(:controller => "stories", :action => "update", :id => "1", :project_id => "1")
    end
    it "recognizes and generates #destroy" do
      { :delete => "/projects/1/stories/1" }.should route_to(:controller => "stories", :action => "destroy", :id => "1", :project_id => "1")
    end
    it "recognizes and generates #open" do
      { :get => "/projects/1/stories/open" }.should route_to(:controller => "stories", :action => "open", :project_id => "1")
    end
    it "recognizes and generates #active" do
      { :get => "/projects/1/stories/active" }.should route_to(:controller => "stories", :action => "active", :project_id => "1")
    end
    it "recognizes and generates #done" do
      { :get => "/projects/1/stories/done" }.should route_to(:controller => "stories", :action => "done", :project_id => "1")
    end
  end
end
