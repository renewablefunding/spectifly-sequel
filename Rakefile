require 'bundler'
Bundler.setup
Bundler::GemHelper.install_tasks

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)
task :default => [:spec]

require 'sequel'
require 'spectifly'
require 'spectifly/builder'

namespace 'spectifly' do
  namespace 'sequel' do
    desc 'Generate migration from entity definition file'
    task :generate, [:entity_type] => [:environemnt] do |t, args|
    end

    desc 'Generate migrations for all new entity defintiions'
    task :generate_all => [:environment] do |t|
    end

    task :default => [:generate_all]
  end
end
