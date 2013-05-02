require 'bundler'
Bundler.setup
Bundler::GemHelper.install_tasks

require 'sequel'
require 'spectifly/builder'
require 'spectifly'

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

task :default => [:spec]
