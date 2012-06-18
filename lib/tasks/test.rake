require 'json'

desc "Import json objects into postgresql"
task :jsonimp => :environment do
  auxuser = User.new(username: "", password: "", email: "")

  # 1. oude users als imported_username importeren
  # 2. projecten importeren en saven onder auxuser
  # 3. sprints importeren en aan projecten hangen en saven
  # 4. stories importeren en aan projecten hangen

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

    puts p.inspect

    puts "sprints:"
    if project["sprints"]
      project["sprints"].each do |s|
        sprint = Sprint.new
        sprint.title = s["name"]
        sprint.uuid = s["_id"]["$oid"]
        sprint.goal = s["goal"]
        sprint.start_date = Time.at(s["start_date"]["$date"] / 1000).to_datetime
        sprint.end_date = Time.at(s["end_date"]["$date"] / 1000).to_datetime
        puts sprint.inspect
      end
    end

  end
end