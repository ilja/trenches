class Story
  include Mongoid::Document
  #include ActsAsList::Mongoid

  validates_presence_of :name, :message => "can't be blank"
  
  #id (autoinc per project?)
  field :name
  field :description
  #list of notes?
  field :status, :default => "open"
  field :priority, :type => Integer #of symbol?
  field :points, :type => Integer
  field :position, :type => Integer
  referenced_in :project
  referenced_in :sprint
  referenced_in :user, :default => nil

  def start(user)
    self.status = "active"
    self.user = user
  end

  def assigned_to
    user
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
  end
end
