class Status
  OPEN = 1
  ACTIVE = 2
  DONE = 3

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

  def Status.to_integer(value)
    if !value.blank?
      Status.all.find_all{|item| item[0] == value.to_s.capitalize}.flatten[1]
    end
  end
end
