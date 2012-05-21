class MembersController < ApplicationController
  before_filter :load_project

  def index
    @members = Member.where(:project_id => @project)
  end

  def create
    user = User.where(:username => params[:username]).first
    unless user.nil?
      member = Member.new(:user => user, :project => @project)
      if member.save
        flash[:notice] = "User invited."
      else
        flash[:error] = "Not a valid username."
      end
    end

    redirect_to user_project_members_path(current_user, @project)
  end

  def destroy
    @member = Member.find(params[:id])
    if @member.destroy
      flash[:notice] = "#{@member.user.username} is no longer a member of this project."
    else
      flash[:error] = 'An error occured while trying to remove the member'
    end

    redirect_to user_project_members_path(current_user, @project)
  end

  def load_project
    @project = Project.find(params[:project_id])
  end
end
