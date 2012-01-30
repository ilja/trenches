require 'active_record'
require 'active_support/core_ext/object/conversions'

class Sprint < ActiveRecord::Base

  attr_accessor :title, :goal, :start_date, :end_date, :project, :stories
  attr_writer :clock

  validates :title, :project, :presence => true

  def initialize(attrs={})
    attrs.each do |k,v| send("#{k}=",v) end

    @start_date = clock.now
    @end_date = (3.weeks).since(clock.now)
    @stories = []
  end

  def define
    @project.add_entry(self)
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
    stories.select{ |s| ["open", "active"].include? s.status }.inject(0) do |sum, story|
      sum + story.points
    end
  end

  def percentage_completed
    done = total_story_points - open_story_points
    done == 0 ? 0 : done / (total_story_points / 100.to_f)
  end


  private

  def clock
    @clock ||= DateTime
  end

end
