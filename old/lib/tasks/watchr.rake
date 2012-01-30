desc "Run watchr"
task :watchr do
  sh %{bundle exec watchr .watchr/watchr.rb}
end