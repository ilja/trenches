Factory.define :project do |f|
  f.name 'my project'
end

Factory.define :sprint do |f|
  f.start_date Time.now - 2.weeks
  f.end_date Time.now + 2.weeks
  f.name 'my sprint'
end

Factory.define :story do |f|
  f.name 'my story'
end

Factory.define :user do |f|
  f.name 'user'
end
