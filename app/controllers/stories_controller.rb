class StoriesController < ApplicationController

  def new
	  @project = Project.find(params[:project_id])
		@story = @project.stories.build
  end

  def create
    @project = Project.find(params[:project_id])
    @story = @project.stories.create(params[:story])

    if @story.save
      flash[:notice] = "'#{@story.title}' was successfully created."
      redirect_to project_backlog_path(@project.owner_username, @project)
    else
      render :new
    end
  end

end