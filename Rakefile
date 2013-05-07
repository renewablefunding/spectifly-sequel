require 'bundler'
Bundler.setup
Bundler::GemHelper.install_tasks

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)
task :default => [:spec]

require 'sequel'
require 'spectifly'
require 'spectifly/builder'
require 'spectifly/sequel'
Dir.glob('lib/tasks/*.rake').each {|r| import r}
