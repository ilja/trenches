require "spec_helper"

describe SprintsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/projects/1/sprints" }.should route_to(:controller => "sprints", :action => "index", :project_id => "1")
    end

    it "recognizes and generates #new" do
      { :get => "/projects/1/sprints/new" }.should route_to(:controller => "sprints", :action => "new", :project_id => "1")
    end

    it "recognizes and generates #show" do
      { :get => "/projects/1/sprints/1" }.should route_to(:controller => "sprints", :action => "show", :id => "1", :project_id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/projects/1/sprints/1/edit" }.should route_to(:controller => "sprints", :action => "edit", :id => "1", :project_id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/projects/1/sprints" }.should route_to(:controller => "sprints", :action => "create", :project_id => "1")
    end

    it "recognizes and generates #update" do
      { :put => "/projects/1/sprints/1" }.should route_to(:controller => "sprints", :action => "update", :id => "1", :project_id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/projects/1/sprints/1" }.should route_to(:controller => "sprints", :action => "destroy", :id => "1", :project_id => "1")
    end

  end
end
