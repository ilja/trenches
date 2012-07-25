require 'active_record'
require 'digest/md5'

class Story < ActiveRecord::Base
  belongs_to :project, :touch => true
  belongs_to :sprint, :touch => true
  belongs_to :user

  attr_accessible :title, :body, :points, :status, :moscow, :project, :sprint_position, :sprint
  attr_accessor :uuid
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

  def self.cache_key
    Digest::MD5.hexdigest "#{maximum(:updated_at)}.try(:to_i)-#{count}"
  end

end
