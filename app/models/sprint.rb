require 'active_record'
require 'active_support/core_ext/object/conversions'

class Sprint < ActiveRecord::Base
  belongs_to :project, :touch => true
  has_many :stories, :order => :sprint_position

  attr_accessible :title, :goal, :start_date, :end_date, :project, :clock
  attr_writer :clock
  attr_accessor :uuid

  validates :title, :project, :presence => true

  after_initialize :default_values

  def default_values
    return unless new_record?

    self.start_date = clock.now
    self.end_date = (3.weeks).since(clock.now)
  end

  def total_work_days
    total_days.select{|d| (1..5).include?(d.wday) }
  end

  def total_days
    start_date.to_date..end_date.to_date
  end

  def remaining_work_days(day)
    ((day+1).to_date..end_date.to_date).select{|d|(1..5).include?(d.wday)}
  end

  def spent_work_days(day)
    (start_date.to_date..day.to_date).select{|d|(1..5).include?(d.wday)}
  end

  def total_story_points
    stories.inject(0) { |sum, story| sum += story.points; sum }
  end

  def open_story_points
    open_stories = stories.select { |s| [Status::OPEN, Status::ACTIVE].include? s.status }
    open_stories.inject(0) do |sum, story|
      sum += story.points
      sum
    end
  end

  def percentage_completed
    done = total_story_points - open_story_points
    done == 0 ? 0 : done / (total_story_points / 100.to_f)
  end

  def add_story(story)
    stories << story
    story.sprint = self
  end

  private

  def clock
    @clock ||= DateTime
  end

end
