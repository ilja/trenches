class SprintsController < ApplicationController
  before_filter :load_project
  before_filter :load_sprint, :except => [:index, :new, :create]

  def index
  end

  def new
    @sprint = Sprint.new
  end

  def create
    @sprint = @project.sprints.create(params[:sprint])

    if @sprint.save
      flash[:notice] = "'#{@sprint.title}' was successfully created."
      redirect_to project_sprints_path(@project.owner_username, @project)
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @sprint.update_attributes(params[:sprint])
      redirect_to project_sprints_path(@project.owner_username, @project), :notice => 'Sprint updated'
    else
      render :edit
    end
  end

  def destroy
    if @sprint.destroy
      flash[:notice] = 'Sprint deleted.'
    else
      flash[:error] = 'An error occured while trying to delete the sprint'
    end

    redirect_to project_sprints_path(@project.owner_username, @project)
  end

  def planning

  end


  def add_and_sort_stories
    #authorize! :update, @sprint

    unless params[:story].blank?
      params[:story].each_with_index do |story_id, index|
        story = Story.find(story_id)
        story.update_attributes(:sprint_position => index+1, :sprint => @sprint)
      end
    end
    render :nothing => true
  end

  def remove_and_sort_stories
    #authorize! :update, @sprint

    unless params[:story].blank?
      params[:story].each_with_index do |story_id, index|
        story = Story.find(story_id)
        story.update_attributes(:sprint_position => 0, :sprint => nil)
      end
    end
    render :nothing => true
  end

  private

  def load_project
    @project = Project.find(params[:project_id])
  end

  def load_sprint
    @sprint = @project.sprints.find(params[:id])
  end


end
