class ProjectsController < ApplicationController
  before_filter :load_project, :except => [:index, :new, :create]

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
  end

  def edit
  end

  def update
    if @project.update_attributes(params[:project])
      redirect_to user_projects_path(current_user), :notice => 'Project updated'
    else
      render :edit
    end
  end

  def destroy
    if @project.destroy
      flash[:notice] = 'Project deleted.'
    else
      flash[:error] = 'An error occured while trying to delete the project'
    end

    redirect_to user_projects_path(current_user)
  end

  def backlog
  end

  private

  def load_project
    @project = Project.find(params[:id])
  end
end
