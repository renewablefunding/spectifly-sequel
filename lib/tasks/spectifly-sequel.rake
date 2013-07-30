require 'rake'
require 'spectifly/sequel'
require 'spectifly/tasks'

namespace 'spectifly' do
  namespace 'sequel' do
    desc 'Generate migration from entity definition file'
    Spectifly::Task.new('generate', [:entity_type]) do |spectifly, args|
      # need to use some sort of factory to determine what type of configuration
      # object we need on the Spectifly::Task#configure! method
      configuration = Spectifly::Sequel::Configuration.new File.join(Dir.pwd, 'config', 'spectifly.yml')
      Spectifly::Sequel::MigrationGenerator.new(args[:entity_type], configuration).run!
    end
  end
end
