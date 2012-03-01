class StoriesController < ApplicationController

  def new
	  @project = Project.find(params[:project_id])
		@story = @project.stories.build
  end

end