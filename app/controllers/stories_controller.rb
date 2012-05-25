class StoriesController < ApplicationController
  before_filter :load_project
  before_filter :load_story, :except => [:new, :create]

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
  end

  def update
    if @story.update_attributes(params[:story])
      redirect_to project_backlog_path(@project.owner_username, @project), :notice => 'Story updated'
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
        redirect_to(request.referer, :notice => "story started")
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
