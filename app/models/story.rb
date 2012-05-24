require 'active_record'

class Story < ActiveRecord::Base

  belongs_to :project
  belongs_to :sprint

  attr_accessible :title, :body, :points, :status, :moscow, :project_id, :sprint_position, :sprint

  validates :title, :project_id,  :presence => true

  def publish
    project.add_story(self)
  end

  def assigned_points
    self.points == 0 ? "?" : self.points
  end

end
