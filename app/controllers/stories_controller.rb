class StoriesController < ApplicationController
  before_filter :load_project

  helper_method :show_scope

  # GET /stories
  # GET /stories.xml
  def index
    if show_scope == "all"
      @stories = @project.stories
    else
      @stories = @project.stories.where(:status => show_scope)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @stories }
    end
  end

  # GET /stories/1
  # GET /stories/1.xml
  def show
    @story = Story.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @story }
    end
  end
  
  def open
    @stories = @project.stories.pending    
    render :index
  end
  
  def active
    @stories = @project.stories.active
    render :index
  end
  
  def done
    @stories = @project.stories.done
    render :index
  end
  

  # GET /stories/new
  # GET /stories/new.xml
  def new
    @story = Story.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @story }
    end
  end

  # GET /stories/1/edit
  def edit
    @story = Story.find(params[:id])
  end

  # POST /stories
  # POST /stories.xml
  def create
    @story = @project.stories.build(params[:story])
    
    respond_to do |format|
      if @story.save
        format.html { redirect_to(backlog_path(@project), :notice => "'#{@story.name}' was successfully created.") }
        format.xml  { render :xml => @story, :status => :created, :location => @story }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @story.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /stories/1
  # PUT /stories/1.xml
  def update
    @story = Story.find(params[:id])

    respond_to do |format|
      if @story.update_attributes(params[:story])
        format.html { redirect_to(backlog_path(@project), :notice => "'#{@story.name}' was successfully updated.") }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @story.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /stories/1
  # DELETE /stories/1.xml
  def destroy
    @story = Story.find(params[:id])
    storyname = @story.name
    @story.destroy

    respond_to do |format|
      format.html { redirect_to(backlog_url(@project), :notice => "'#{storyname}' was successfully deleted.") }
      format.xml  { head :ok }
    end
  end

  def start
    @story = @project.stories.find(params[:story_id])
    
    if current_user
      @story.start(current_user)

      #todo ajax
      if @story.save!
        sprint = @project.sprints.find(@story.sprint_id)
        redirect_to( project_sprint_path(@project, sprint), :notice => "story started")
      else
        #error
      end
           
    end
  end
  
  def load_project
    @project = Project.find(params[:project_id])
  end

  private
  def show_scope
    %w[open active done].include?(params[:show]) ?  params[:show] : "all"
  end
end
