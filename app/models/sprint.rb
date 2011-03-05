class Sprint
  include Mongoid::Document
  field :name, :type => String
  field :start_date, :type => Date
  field :end_date, :type => Date
  embedded_in :project, :inverse_of => :sprints
  references_many :stories

  validates_presence_of :start_date, :end_date, :name
end
