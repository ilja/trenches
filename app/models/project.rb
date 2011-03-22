class Project
  include Mongoid::Document
  include Mongoid::Timestamps
  
  validates_presence_of :name, :message => "can't be blank"
  
  field :name
  references_many :stories, :dependent => :delete
  embeds_many :sprints do
    def active_for_user(user)
      @target.select { |sprint| sprint.id == user.sprint_id }
    end
  end

  def backlog
    stories.where(:sprint_id => nil)
  end

  def active_sprint_for(user)
    sprints.find(user.sprint_id)
  end

end
