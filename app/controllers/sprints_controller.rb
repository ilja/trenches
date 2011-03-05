class SprintsController < ApplicationController
  before_filter :load_project
  # GET /sprints
  # GET /sprints.xml
  def index
    @sprints = @project.sprints

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sprints }
    end
  end

  # GET /sprints/1
  # GET /sprints/1.xml
  def show
    @sprint = @project.sprints.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sprint }
    end
  end

  def planning
    @sprint = @project.sprints.find(params[:id])
    respond_to do |format|
      format.html
    end
  end

  # GET /sprints/new
  # GET /sprints/new.xml
  def new
    @sprint = Sprint.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sprint }
    end
  end

  # GET /sprints/1/edit
  def edit
    @sprint = @project.sprints.find(params[:id])
  end

  # POST /sprints
  # POST /sprints.xml
  def create
    @sprint = @project.sprints.build(params[:sprint])

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
    sprintname = @sprint.name
    @sprint.destroy

    respond_to do |format|
      format.html { redirect_to(project_sprints_url, :notice => "'#{sprintname}' was successfully deleted.") }
      format.xml  { head :ok }
    end
  end

  def add_and_sort_stories
    sprint = @project.sprints.find(params[:sprint_id])
    params[:story].each_with_index do |id, index|
      story = Story.criteria.id(id).first
      sprint.stories << story
      story.update_attributes(:position => index+1, :sprint => sprint)
    end
    render :nothing => true
  end

  def remove_and_sort_stories
    params[:story].each_with_index do |id, index|
      story = Story.criteria.id(id).first
      story.update_attributes(:position => index+1, :sprint_id => nil)
    end
    render :nothing => true
  end

  def load_project
    @project = Project.find(params[:project_id])
  end

end
