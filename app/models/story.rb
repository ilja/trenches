require 'active_record'

class Story < ActiveRecord::Base

  attr_accessor :title, :body, :project, :points, :status

  validates :title, :project,  :presence => true

  def initialize(attrs={})
    attrs.each do |k,v| send("#{k}=",v) end
  end

  def publish
    @project.add_entry(self)
  end
end
