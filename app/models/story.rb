require 'active_record'

class Story < ActiveRecord::Base

  belongs_to :project
  belongs_to :sprint

  attr_accessible :title, :body, :points, :status, :moscow, :project_id

  validates :title, :project_id,  :presence => true

  def publish
    @project.add_entry(self)
  end
end
