class User
  include Mongoid::Document
  field :provider, :type => String
  field :uid, :type => String
  field :name, :type => String
  references_many :stories
  referenced_in :sprint

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["user_info"]["nickname"]
    end
  end

  def assign_active_sprint(sprint)
    self.sprint = sprint
  end

  def active_sprint
    sprint
  end

  #def active_sprint_for(project)
   # sprint = project.sprints.where(:user => self).first
    #sprint
  #end

end
