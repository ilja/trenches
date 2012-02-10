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
end
