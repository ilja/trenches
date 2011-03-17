class ProjectsController < ApplicationController  

  # GET /projects
  # GET /projects.xml
  def index
    @projects = Project.all
    authorize! :read, @project

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.xml
  def show
    @project = Project.find(params[:id])
    authorize! :read, @project

    # redirect to active sprint if exists and is in this project
    if current_user && @project.sprints.active_for_user(current_user).blank? == false
      sprint =  @project.sprints.active_for_user(current_user)
      redirect_to project_sprint_path(@project, sprint)
    else    
      # no sprint set or not logged in
      redirect_to backlog_path(@project)    
    end
  end

  # GET /projects/new
  # GET /projects/new.xml
  def new
    @project = Project.new
    authorize! :create, Project

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
    authorize! :read, @project
  end

  # POST /projects
  # POST /projects.xml
  def create
    @project = Project.new(params[:project])
    authorize! :create, @project

    respond_to do |format|
      if @project.save
        format.html { redirect_to(projects_path, :notice => "'#{@project.name}' was successfully created.") }
        format.xml  { render :xml => @project, :status => :created, :location => @project }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.xml
  def update
    @project = Project.find(params[:id])
    authorize! :update, @project

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to(projects_path, :notice => "'#{@project.name}' was successfully updated.") }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.xml
  def destroy
    @project = Project.find(params[:id])
    authorize! :destroy, @project

    projectname = @project.name
    @project.destroy

    respond_to do |format|
      format.html { redirect_to(projects_url, :notice => "'#{projectname}' was successfully deleted.") }
      format.xml  { head :ok }
    end
  end
end
