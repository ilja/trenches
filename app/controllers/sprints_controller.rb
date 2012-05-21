class SprintsController < ApplicationController
  def index
    @project = Project.find(params[:project_id])
  end

  def new
    @project = Project.find(params[:project_id])
    @sprint = Sprint.new
  end

  def create
    @project = Project.find(params[:project_id])
    @sprint = @project.sprints.create(params[:sprint])

    if @sprint.save
      flash[:notice] = "'#{@sprint.title}' was successfully created."
      redirect_to project_sprints_path(@project.owner_username, @project)
    else
      render :new
    end
  end

  def edit
    @project = Project.find(params[:project_id])
    @sprint = @project.sprints.find(params[:id])
  end

  def update
    @project = Project.find(params[:project_id])
    @sprint = @project.sprints.find(params[:id])

    if @sprint.update_attributes(params[:sprint])
      redirect_to project_sprints_path(@project.owner_username, @project), :notice => 'Sprint updated'
    else
      render :edit
    end
  end

  def destroy
    @project = Project.find(params[:project_id])
    @sprint = @project.sprints.find(params[:id])

    if @sprint.destroy
      flash[:notice] = 'Sprint deleted.'
    else
      flash[:error] = 'An error occured while trying to delete the sprint'
    end
    
    redirect_to project_sprints_path(@project.owner_username, @project)
  end


end
