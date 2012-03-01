require 'active_record'

class Story < ActiveRecord::Base

  attr_accessible :title, :body, :points, :status, :moscow

  validates :title, :project_id,  :presence => true

  # def initialize(attrs={})
  #   attrs.each do |k,v| send("#{k}=",v) end
  # end

  def publish
    @project.add_entry(self)
  end
end
