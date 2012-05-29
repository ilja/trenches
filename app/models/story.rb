require 'active_record'

class Story < ActiveRecord::Base
  belongs_to :project
  belongs_to :sprint
  belongs_to :user

  attr_accessible :title, :body, :points, :status, :moscow, :project, :sprint_position, :sprint

  validates :title, :project_id,  :presence => true

  def publish
    project.add_story(self)
  end

  def assigned_points
    self.points == 0 ? "?" : self.points
  end

  def start(user)
    self.status = Status::ACTIVE
    self.user = user
  end

  def finish(user)
    self.status = Status::DONE
    self.user = user
  end

  def assigned_to
    user
  end

end
