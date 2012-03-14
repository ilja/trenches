class MembersController < ApplicationController
  def index
    @project = Project.find(params[:project_id])
    @members = Member.where(:project_id => @project)
  end

  def create
    @project = Project.find(params[:project_id])
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
    @project = Project.find(params[:project_id])
    @member = Member.find(params[:id])
    if @member.destroy
      flash[:notice] = "#{@member.user.username} is no longer a member of this project."
    else
      flash[:error] = 'An error occured while trying to remove the member'
    end

    redirect_to user_project_members_path(current_user, @project)
  end
end
