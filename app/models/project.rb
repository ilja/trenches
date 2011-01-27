class Project
  include Mongoid::Document
  
  field :name
  references_many :stories, :dependent => :delete
end
