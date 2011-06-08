module SprintsHelper
  def total_work_days_ticks(sprint)
    result = []
    counter = 0
    sprint.total_work_days.each do |day|
      result << [counter, day.mday]
      counter += 1
    end
    result.to_json
  end
end
