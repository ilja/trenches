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

  def edit
    @project = Project.find(params[:project_id])
    @story = @project.stories.find(params[:id])

  end

  def update
    @project = Project.find(params[:project_id])
    @story = @project.stories.find(params[:id])


    if @story.update_attributes(params[:story])
      redirect_to project_backlog_path(@project.owner_username, @project), :notice => 'Story updated'
    else
      render :edit
    end
  end

  def destroy
    @project = Project.find(params[:project_id])
    @story = @project.stories.find(params[:id])

    if @story.destroy
      flash[:notice] = 'Story deleted.'
    else
      flash[:error] = 'An error occured while trying to delete the story'
    end

    redirect_to project_backlog_path(@project.owner_username, @project)
  end

end
