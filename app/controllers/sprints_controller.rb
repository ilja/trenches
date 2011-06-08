class SprintsController < ApplicationController
  before_filter :load_project
  helper_method :show_scope
  respond_to :html

  def index
    @sprints = @project.sprints
    authorize! :read, @sprints
    respond_with @sprints
  end

  def show
    @sprint = @project.sprints.find(params[:id])
    authorize! :read, @sprint

    if show_scope == "all"
      @stories = @sprint.stories.asc(:position)
    elsif show_scope == "my"
      @stories = @sprint.stories.stories_for(current_user).asc(:position)
    else
      @stories = @sprint.stories.where(:status => show_scope).asc(:position)
    end
    
    respond_with @sprint
  end

  def planning
    @sprint = @project.sprints.find(params[:id])
    authorize! :read, @sprint
    respond_with @sprint
        # respond_to do |format|
        #   format.html
        # end
  end

  def new
    authorize! :create, Sprint
    @sprint = Sprint.new
    respond_with @sprint
  end

  def edit
    @sprint = @project.sprints.find(params[:id])
    authorize! :read, @sprint
  end

  def create
    # todo: fix date select assignment failure
    @sprint = @project.sprints.build(params[:sprint])
    authorize! :create, @sprint

    if @sprint.save
      redirect_to project_sprints_path(@project), :notice => "'#{@sprint.name}' was successfully created."
    else
      render :new
    end
  end

  def update
    @sprint = @project.sprints.find(params[:id])
    authorize! :update, @sprint

    if @sprint.update_attributes(params[:sprint])
      redirect_to project_sprints_path(@project),  :notice => "'#{@sprint.name}' was successfully updated."
    else
      render :edit
    end

  end

  def destroy
    @sprint = @project.sprints.find(params[:id])
    authorize! :destroy, @sprint
    sprintname = @sprint.name
    @sprint.destroy
    redirect_to project_sprints_url, :notice => "'#{sprintname}' was successfully deleted."
  end

  def add_and_sort_stories
    sprint = @project.sprints.find(params[:sprint_id])
    authorize! :update, sprint

    unless params[:story].blank?
      params[:story].each_with_index do |id, index|
        story = Story.criteria.id(id).first
        sprint.stories << story
        story.update_attributes(:position => index+1, :sprint => sprint)
      end
    end
    render :nothing => true
  end

  def remove_and_sort_stories
    authorize! :update, Sprint

    unless params[:story].blank?
      params[:story].each_with_index do |id, index|
        story = Story.criteria.id(id).first
        story.update_attributes(:position => index+1, :sprint_id => nil)
      end
    end
    render :nothing => true
  end

  def activate
    if current_user
      sprint = @project.sprints.find(params[:id])
      current_user.assign_active_sprint(sprint)

      if current_user.save
        redirect_to project_sprint_path(@project, current_user.active_sprint), :notice => "Active sprint set."
      end

    end
  end

  private

  def load_project
    @project = Project.find(params[:project_id])
    authorize! :read, @project
  end

  def show_scope
    %w[open active done my].include?(params[:show]) ?  params[:show] : "all"
  end
end
