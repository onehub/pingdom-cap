require 'bundler/setup'
require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
# require 'cucumber/rake/task'

desc 'Default: run the specs.'
task :default => [:spec ] #, :cucumber]

desc 'Test the pingdom_cap gem.'
RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = ['--color', "--format progress"]
  t.pattern = 'spec/pingdom_cap*/**/*_spec.rb'
end

# desc "Run cucumber features"
# Cucumber::Rake::Task.new do |t|
#  t.cucumber_opts = ['--tags', '~@wip',
#                      '--format', (ENV['CUCUMBER_FORMAT'] || 'progress')]
# end
