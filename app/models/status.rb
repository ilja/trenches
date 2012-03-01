class Status
  OPEN = 0
  ACTIVE = 1
  DONE = 2
    
  def Status.all
    [
      ["Open", Status::OPEN],
      ["Active", Status::ACTIVE],
      ["Done", Status::DONE]      
    ]
  end

  def Status.to_name(value)
    if !value.blank? 
      Status.all.find_all{|item| item[1] == value}.flatten[0]
    end
  end
end