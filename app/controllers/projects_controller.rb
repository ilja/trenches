class ProjectsController < ApplicationController
  before_filter :load_project, :except => [:index, :new, :create]
  helper_method :filters

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
    @latest_sprint = @project.sprints.last
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
    unless params[:show].blank?
      query = params[:show].to_a.inject([]) { |result, value| result << Status.to_integer(value); result }

      @stories = @project.stories.where(:status => query).order(:backlog_position)
    else
      @stories = @project.stories.order(:backlog_position)
    end
  end

  private

  def load_project
    @project = Project.find(params[:id])
  end

  def filters
    %w[open active done]
  end
end
