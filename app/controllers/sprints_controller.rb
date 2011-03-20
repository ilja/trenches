class SprintsController < ApplicationController
  before_filter :load_project
  helper_method :show_scope

  # GET /sprints
  # GET /sprints.xml
  def index
    @sprints = @project.sprints
    authorize! :read, @sprints

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sprints }
    end
  end

  # GET /sprints/1
  # GET /sprints/1.xml
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

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sprint }
    end
  end

  def planning
    @sprint = @project.sprints.find(params[:id])
    authorize! :read, @sprint
    respond_to do |format|
      format.html
    end
  end

  # GET /sprints/new
  # GET /sprints/new.xml
  def new
    authorize! :create, Sprint
    @sprint = Sprint.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sprint }
    end
  end

  # GET /sprints/1/edit
  def edit
    @sprint = @project.sprints.find(params[:id])
    authorize! :read, @sprint
  end

  # POST /sprints
  # POST /sprints.xml
  def create
    @sprint = @project.sprints.build(params[:sprint])
    authorize! :create, @sprint

    respond_to do |format|
      if @sprint.save
        format.html { redirect_to(project_sprints_path(@project), :notice => "'#{@sprint.name}' was successfully created.") }
        format.xml  { render :xml => @sprint, :status => :created, :location => @sprint }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sprint.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sprints/1
  # PUT /sprints/1.xml
  def update
    @sprint = @project.sprints.find(params[:id])
    authorize! :update, @sprint

    respond_to do |format|
      if @sprint.update_attributes(params[:sprint])
        format.html { redirect_to(project_sprints_path(@project),  :notice => "'#{@sprint.name}' was successfully updated.") }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sprint.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sprints/1
  # DELETE /sprints/1.xml
  def destroy
    @sprint = @project.sprints.find(params[:id])
    authorize! :destroy, @sprint
    sprintname = @sprint.name
    @sprint.destroy

    respond_to do |format|
      format.html { redirect_to(project_sprints_url, :notice => "'#{sprintname}' was successfully deleted.") }
      format.xml  { head :ok }
    end
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
