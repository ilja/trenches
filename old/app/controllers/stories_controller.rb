class StoriesController < ApplicationController
  before_filter :load_project
  helper_method :filters
  respond_to :html

  def index
    unless params[:show].blank?
      query = params[:show].to_a.select { |value| filters.include?value.to_s }
      @stories = @project.stories.where(:status.in => query).asc(:backlog_position)
    else
      @stories = @project.stories.asc(:backlog_position)
    end

    authorize! :read, @stories
    respond_with @stories
  end

  def show
    @story = Story.find(params[:id])
    authorize! :read, @story
    respond_with @story
  end

  def new
    @story = Story.new
    authorize! :create, Story
    respond_with @story
  end

  def edit
    @story = Story.find(params[:id])
    session[:return_to] = request.referer #remember where we came from
    authorize! :update, @story
  end

  def create
    @story = @project.stories.build(params[:story])
    authorize! :create, @story

    if @story.save
      redirect_to backlog_path(@project), :notice => "'#{@story.name}' was successfully created."
    else
      render :new
    end
  end

  def update
    @story = Story.find(params[:id])
    authorize! :update, @story

    if @story.update_attributes(params[:story])
      redirect_to session[:return_to], :notice => "'#{@story.name}' was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @story = Story.find(params[:id])
    authorize! :destroy, @story
    storyname = @story.name
    @story.destroy
    redirect_to backlog_url(@project), :notice => "'#{storyname}' was successfully deleted."
  end

  def start
    @story = @project.stories.find(params[:story_id])
    authorize! :update, @story

    if current_user
      @story.start(current_user)

      if @story.save!
        sprint = @project.sprints.find(@story.sprint_id)
        redirect_to(request.referer, :notice => "story started")
      else
        #todo: error
      end
    end
  end

  def finish
    @story = @project.stories.find(params[:story_id])
    authorize! :update, @story

    if current_user
      @story.finish(current_user)

      if @story.save!
        sprint = @project.sprints.find(@story.sprint_id)
        redirect_to(request.referer, :notice => "story finished")
      else
        #todo: error
      end
    end
  end

  private

  def load_project
    @project = Project.find(params[:project_id])
    authorize! :read, @project
  end

  def filters
    %w[open active done]
  end
end
