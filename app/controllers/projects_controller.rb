class ProjectsController < ApplicationController
  respond_to :html

  def index
    @projects = Project.all
    authorize! :read, @project
    respond_with(@projects)
  end

  def show
    @project = Project.find(params[:id])
    authorize! :read, @project

    if current_user && @project.active_sprint_for(current_user).blank? == false
      redirect_to project_sprint_path(@project, @project.active_sprint_for(current_user))
    else
      redirect_to backlog_path(@project)
    end
  end

  def new
    @project = Project.new
    authorize! :create, Project
    respond_with(@project)
  end

  def edit
    @project = Project.find(params[:id])
    authorize! :read, @project
  end

  def create
    @project = Project.new(params[:project])
    authorize! :create, @project

    if @project.save
      redirect_to projects_path, :notice => "'#{@project.name}' was successfully created."
    else
      render :new
    end
  end

  def update
    @project = Project.find(params[:id])
    authorize! :update, @project

    if @project.update_attributes(params[:project])
      redirect_to projects_path, :notice => "'#{@project.name}' was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @project = Project.find(params[:id])
    authorize! :destroy, @project

    projectname = @project.name
    if @project.destroy
      flash[:notice] = "'#{projectname}' was successfully deleted."
    else
      flash[:error] = "Unable to delete '#{projectname}'."
    end
    redirect_to projects_url
  end

  def sort_stories
    @project = Project.find(params[:project_id])
    authorize! :update, @project

    unless params[:story].blank?
      params[:story].each_with_index do |id, index|
        story = Story.find(id)
        story.update_attributes(:backlog_position => index+1)
      end
    end
    render :nothing => true
  end

end
