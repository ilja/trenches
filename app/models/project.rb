require 'active_record'

class Project < ActiveRecord::Base

  attr_writer :sprint_maker

  has_many :members, :dependent => :destroy
  has_many :sprints, :dependent => :destroy
  has_many :stories, :dependent => :destroy

  validates :name, :presence => true

  def start user
    members.build(:user => user, :project_owner => true)
    save
  end

  def add_story(story)
    stories << story
  end

  def add_sprint(sprint)
    sprints << sprint
  end

  def owner
    members.where(:project_owner => true).first
  end

  def owner_username
    #todo denormalize?
    owner.user.username
  end

  def backlog
    stories.where(:sprint_id => nil)
  end

  private

end
