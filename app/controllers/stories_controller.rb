class StoriesController < ApplicationController

  def new
	  @project = Project.find(params[:project_id])
		@story = Story.new
  end

end