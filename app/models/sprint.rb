class Sprint
  include Mongoid::Document
  field :name, :type => String
  embedded_in :project, :inverse_of => :sprints
end
