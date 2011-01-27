class Project
  include Mongoid::Document
  
  validates_presence_of :name, :message => "can't be blank"
  
  field :name
  references_many :stories, :dependent => :delete
end
