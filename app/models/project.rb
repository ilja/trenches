class Project
  include Mongoid::Document
  include Mongoid::Timestamps

  validates_presence_of :name, :message => "can't be blank"

  field :name
  references_many :stories, :dependent => :delete
  embeds_many :sprints

  def backlog
    stories.where(:sprint_id => nil)
  end

  def active_sprint_for(user)
    sprints.for_ids(user.sprint_id).first
  end
end
