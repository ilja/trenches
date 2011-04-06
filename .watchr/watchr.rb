require 'notifier'

$pass = File.join(File.expand_path(File.dirname(__FILE__)), 'success.png')
$fail = File.join(File.expand_path(File.dirname(__FILE__)), 'failure.png')

def run_spec(file)
  unless File.exist?(file)
    puts "#{file} does not exist"
    return
  end

  puts "Running #{file}"
  output = %x[bundle exec rspec --drb --tty --colour -f doc #{file}]
  puts output
 
  last_output = output.split("\n").last
  growl file.split("/").last, last_output.gsub(/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]/, '')
end

watch("spec/.*/*_spec\.rb") do |match|
  run_spec match[0]
end

watch("app/(.*/.*)\.rb") do |match|
  run_spec %{spec/#{match[1]}_spec.rb}
end

def growl file, message
  if message.match(/\s0\s(errors|failures)/)
    title = "#{file} passed"
    image = $pass
  else
    title = "#{file} failed"
    image = $fail
  end

  Notifier.default_notifier = :notify_send
  Notifier.notify(
    :image   => image,
    :title   => title,
    :message => message
  )
end