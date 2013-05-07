require 'rake'
require 'spectifly/sequel'

namespace 'spectifly' do
  namespace 'sequel' do
    desc 'Generate migration from entity definition file'
    task :generate, [:entity_type] do |t, args|
      Spectifly::Sequel.configure_with File.join(Dir.pwd, 'config', 'spectifly.yml')
      Spectifly::Sequel::MigrationGenerator.new(args[:entity_type]).run!
    end
  end
end
