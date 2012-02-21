class ProjectsController < ApplicationController
  def index
    @projects = current_user.projects
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(params[:project])

    if @project.start(current_user)
      redirect_to user_projects_path(current_user), :notice => 'Project saved'
    else
      render :new
    end
  end

  def show
    @project = Project.find(params[:id])
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])

    if @project.update_attributes(params[:project])
      redirect_to user_projects_path(current_user), :notice => 'Project updated'
    else
      render :edit
    end
  end

  def destroy
    @project = Project.find(params[:id])
    if @project.destroy
      flash[:notice] = 'Project deleted.'
    else
      flash[:error] = 'An error occured while trying to delete the project'
    end

    redirect_to user_projects_path(current_user)
  end

  def backlog
    @project = Project.find(params[:id])
  end
end
