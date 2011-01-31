class Story
  include Mongoid::Document
  
  validates_presence_of :name, :message => "can't be blank"
  
  #id (autoinc per project?)
  field :name
  field :description
  #lijstje notes
  field :status, :default => "open"
  field :priority, :type => Integer #of symbol?
  field :points, :type => Integer
  referenced_in :project
  
  class << self
    def open
      criteria.where(:status => "open")
    end
    def active
      criteria.where(:status => "active")
    end
    def done
      criteria.where(:status => "done")
    end
  end

end
