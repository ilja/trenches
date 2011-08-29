class Story
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Versioning

  validates_presence_of :name, :message => "can't be blank"

  field :name
  field :description
  #list of notes?
  field :status, :type => String, default: "open"
  field :priority, :type => Integer
  field :points, :type => Integer
  field :moscow, :type => Integer
  field :backlog_position, :type => Integer
  field :position, :type => Integer
  field :last_edited_by, :type => String
  field :done_date, :type => Date
  referenced_in :project
  referenced_in :sprint
  referenced_in :user#, default: nil

  def start(user)
    self.status = "active"
    self.user = user
  end

  def finish(user)
    self.status = "done"
    self.user = user
    self.done_date = DateTime.now
  end

  def assigned_to
    user
  end

  # show ? instead of 0
  def assigned_points
    self.points == 0 ? "?" : self.points
  end

  class << self
    def pending
      criteria.where(:status => "open").asc(:position)
    end
    def active
      criteria.where(:status => "active").asc(:position)
    end
    def done
      criteria.where(:status => "done").asc(:position)
    end
    def stories_for(user)
      criteria.where(:user_id => user.id).asc(:position)
    end
  end
end
