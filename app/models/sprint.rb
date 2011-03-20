class Sprint
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, :type => String
  field :goal, :type => String
  field :start_date, :type => Date
  field :end_date, :type => Date
  embedded_in :project, :inverse_of => :sprints
  references_many :stories
  references_many :users 

  validates_presence_of :start_date, :end_date, :name

  # give the total number of workdays in this sprint
  def total_work_days
    (start_date..end_date).select{|d|(1..5).include?(d.wday)}    
  end

  def total_days
    start_date..end_date
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

  def done_story_points_on(date)    
    stories.done.where(:done_date.lte => date).inject(0) do |sum, story|
      sum + story.points
    end
  end

  def open_story_points
    stories.any_in(:status => ["open", "active"]).inject(0) do |sum, story|
      sum + story.points
    end
  end

  def done_story_points_per_workday
    count = 0
    all_days = start_date..end_date
    result = []
    all_days.each do |day|
      result << [count, self.done_story_points_on(day)]      
      count += 1
    end

    result
  end 

  def workdays_as_ticks
    result = []
    counter = 0
    total_days.each do |day|
      result << [counter, day.mday]
      counter += 1
    end

    result
  end

  def open_story_points_per_workday
    count = 0
    result = []
  


    total_days.each do |day|
   
     # puts  Date.new(2011, 03, 17)
     # puts "Day: #{day}: #{done_story_points_on(day)}"
      open = total_story_points - done_story_points_on(day)
      result << [count, open]
     count += 1
    end

    result
  end 
end
