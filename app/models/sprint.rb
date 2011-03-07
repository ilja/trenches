class Sprint
  include Mongoid::Document
  field :name, :type => String
  field :start_date, :type => Date
  field :end_date, :type => Date
  embedded_in :project, :inverse_of => :sprints
  references_many :stories

  validates_presence_of :start_date, :end_date, :name
  
  # give the total workdays in this sprint
  def total_work_days
    (start_date..end_date).select{|d|(1..5).include?(d.wday)}    
  end
  
  # give the total remaining workdays in this sprint on the given date
  def remaining_work_days(day)
    (day+1..end_date).select{|d|(1..5).include?(d.wday)}    
  end
  
  # give the total spent workdays in this sprint on the given date
  def spent_work_days(day)
    (start_date..day).select{|d|(1..5).include?(d.wday)}    
  end

  def total_story_points
    stories.inject(0) do |sum, story|
      sum + story.points
    end
  end

  def done_story_points(date)
    stories.done.inject(0) do |sum, story|
      sum + story.points
    end
  end

  def open_story_points(date)
    stories.any_in(:status => ["open", "active"]).inject(0) do |sum, story|
      sum + story.points
    end
  end
end
