require 'json'

desc "Import json objects into postgresql"
task :jsonimp => :environment do
  #auxuser = User.new(username: "", password: "", email: "")
  auxuser = User.new(username: "auxilium", password: "toeter", email: "systeembeheer@auxilium.nl")
  auxuser.save!

  # 1. oude users als imported_username importeren
  oldusers = {}
  userlines = IO.readlines('../users.json')  
  userlines.each do |line|
    userhash = JSON.parse line
    u = User.new
    oldname = userhash["name"]
    u.username = "old_#{oldname}"
    u.uuid = userhash["_id"]["$oid"]
    u.email = "#{oldname}@example.com"
    u.password = "toeter"
    oldusers.store u.uuid, u
    u.save!
  end
  puts "imported #{oldusers.count} users"

  # 2. projecten importeren en saven onder auxuser
  projects = {}
  sprints = {}
  lines = IO.readlines('../projects.json')
  lines.each do |line|
    project = JSON.parse(line)
    p = Project.new
    p.name = project["name"]
    p.uuid = project["_id"]["$oid"]
    created = Time.at(project["created_at"]["$date"] / 1000).to_datetime unless project["created_at"].nil?
    updated = Time.at(project["updated_at"]["$date"] / 1000).to_datetime unless project["updated_at"].nil?
    p.created_at = created
    p.updated_at = updated
    p.start(auxuser)
    projects.store p.uuid, p
    p.save!

    # 3. sprints importeren en aan projecten hangen en saven
    if project["sprints"]
      project["sprints"].each do |s|
        sprint = Sprint.new
        sprint.title = s["name"]
        sprint.uuid = s["_id"]["$oid"]
        sprint.goal = s["goal"]
        sprint.start_date = Time.at(s["start_date"]["$date"] / 1000).to_datetime
        sprint.end_date = Time.at(s["end_date"]["$date"] / 1000).to_datetime
        p.add_sprint(sprint)
        
        sprint.save!
        sprints.store sprint.uuid, sprint
      end
    end
    puts "added #{p.sprints.count} sprints to project #{p.name}"
   
  end
  puts "stored #{projects.count} projects"

  # 4. stories importeren en aan projecten hangen
  stories = {}
  storylines = IO.readlines('../stories.json')
  storylines.each do |line|
    storyhash = JSON.parse line
    story = Story.new
    story.uuid = storyhash["_id"]["$oid"]
    story.backlog_position = storyhash["backlog_position"] unless storyhash["backlog_position"].nil?
    story.sprint_position = storyhash["position"] unless storyhash["position"].nil?
    story.body = storyhash["description"] unless storyhash["description"].nil?
    story.title = storyhash["name"]
    story.moscow = storyhash["moscow"]
    story.points = storyhash["points"]
    if storyhash["status"] == "open"
      story.status = Status::OPEN
    elsif storyhash["status"] == "active"
      story.status = Status::ACTIVE
    elsif storyhash["status"] == "done"
      story.status = Status::DONE
    end
    
    unless storyhash["created_at"].nil? || storyhash["created_at"]["$date"].nil?  
      story.created_at = Time.at(storyhash["created_at"]["$date"] / 1000).to_datetime
    end
    unless storyhash["updated_at"].nil? || storyhash["updated_at"]["$date"].nil?    
      story.updated_at = Time.at(storyhash["updated_at"]["$date"] / 1000).to_datetime
    end
    # unless storyhash["done_date"].nil? || storyhash["done_date"]["$date"].nil?    
    #   story.done_date = Time.at(storyhash["done_date"]["$date"] / 1000).to_datetime
    # end

    unless storyhash["project_id"].nil?
      project = projects[storyhash["project_id"]["$oid"]]
      project.add_story story
    end
    unless storyhash["user_id"].nil?
      user = oldusers[storyhash["user_id"]["$oid"]]
      story.user = user
    end
    unless storyhash["sprint_id"].nil?
      sprint = sprints[storyhash["sprint_id"]["$oid"]]
      sprint.add_story story unless sprint.blank?
      #story.sprint = sprint
    end
   
    stories.store story.uuid, story
    story.save!
  end
  puts "imported #{stories.count} stories"


end