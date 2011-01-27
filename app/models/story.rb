class Story
  include Mongoid::Document
  #id (autoinc per project?)
  field :name
  field :description
  #lijstje notes
  field :priority, :type => Integer #of symbol?
  field :points, :type => Integer
  
end
