require 'active_record'

class Project < ActiveRecord::Base

#  attr_reader :stories
#  attr_reader :sprints
#  attr_writer :story_maker
#  attr_writer :sprint_maker
#  attr_accessor :name

  has_many :members, :dependent => :destroy

  validates :name, :presence => true

 # def initialize
 #   @stories = []
 #   @sprints = []
 # end
  def start user
    members.build(:user => user, :project_owner => true)
    save
  end

  def new_story(*args)
    story_maker.call(*args).tap do |s|
      s.project = self
    end
  end

  def add_story(story)
    stories << story
  end

  def new_sprint(*args)
    sprint_maker.call(*args).tap do |s|
      s.project = self
    end
  end

  def owner
    members.where(:project_owner => true).first
  end

  def owner_username
    owner.user.username
  end

  private

  def story_maker
    @story_maker ||= Story.public_method(:new)
  end

  def sprint_maker
    @sprint_maker ||= Sprint.public_method(:new)
  end
end
