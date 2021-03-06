class StoriesController < SecureController
  before_filter :load_project
  before_filter :load_story, :except => [:new, :create]
  respond_to :html, :json
  def new
    @story = @project.stories.build
  end

  def create
    @story = @project.stories.create(params[:story])

    if @story.save
      flash[:notice] = "'#{@story.title}' was successfully created."
      redirect_to project_backlog_path(@project.owner_username, @project)
    else
      render :new
    end
  end

  def edit
    respond_with do |format|
      format.html do
        render :partial => "stories/form", :locals => { :story => @story, :project => @project, :remote => false, :button_name => "Update story" }, :layout => false
      end
      format.json do
        render :json => @story
      end
    end
  end

  def update
    if @story.update_attributes(params[:story])
      respond_with do |format|
        format.html do
          if request.xhr?
            render :partial => "story", :locals => { :story => @story, :sortable=> false }, :layout => false, :status => :created
          else
            redirect_to project_backlog_path(@project.owner_username, @project), :notice => 'Story updated'
          end
        end
        format.js do
          render :partial => "story", :locals => { :story => @story, :sortable=> false }, :layout => false, :status => :created
        end
      end
    else
      render :edit
    end
  end

  def destroy
    if @story.destroy
      flash[:notice] = 'Story deleted.'
    else
      flash[:error] = 'An error occured while trying to delete the story'
    end

    redirect_to project_backlog_path(@project.owner_username, @project)
  end

  def start
    #authorize! :update, @story

    if current_user
      @story.start(current_user)

      if @story.save!
        sprint = @project.sprints.find(@story.sprint_id)
        redirect_to(request.referer, :notice => "Story started")
      else
        #todo: error
      end
    end
  end

  def finish
    #authorize! :update, @story

    if current_user
      @story.finish(current_user)

      if @story.save!
        sprint = @project.sprints.find(@story.sprint_id)
        redirect_to(request.referer, :notice => "Story finished")
      else
        #todo: error
      end
    end
  end

  private

  def load_project
    @project = Project.find(params[:project_id])
  end

  def load_story
    @story = @project.stories.find(params[:id])
  end

end
