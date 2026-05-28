require 'bundler/gem_tasks'

require 'rake/testtask'
Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/*test.rb']
  t.verbose = true
end

# Redefine release task to push to Gemfury
Rake::Task['release'].clear
task :release => %i[build release:guard_clean] do
  sh "curl --fail --silent -F package=@pkg/ksr-#{Ksr::VERSION}.gem https://${GEMFURY_API_TOKEN}@push.fury.io/kickstarter/"
end

task default: :test
