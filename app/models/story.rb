class Story
  include Mongoid::Document
  
  validates_presence_of :name, :message => "can't be blank"
  
  #id (autoinc per project?)
  field :name
  field :description
  #lijstje notes
  field :priority, :type => Integer #of symbol?
  field :points, :type => Integer
  referenced_in :project
end
