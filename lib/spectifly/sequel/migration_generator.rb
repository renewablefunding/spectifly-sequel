module Spectifly
  module Sequel
    class MigrationGenerator
      def initialize(entity, migration_path=nil, entity_path=nil, migration_version_type='Integer')
        @migration_path = File.expand_path(migration_path || Spectifly::Sequel.migration_path)
        @entity_definition_path = File.expand_path(entity_path || Spectifly::Sequel.entity_definition_path)
        @migration_version_type = migration_version_type
        @builder = Spectifly::Sequel::Builder.from_path(File.join(@entity_definition_path, entity + '.entity'))
      end

      def run!
        migration_output = @builder.build
        File.open(File.join(@migration_path, migration_name), 'w') { |f| f.write(migration_output) }
      end

      def migration_name
        '%s_create_%s.rb' % [next_migration_version, @builder.model.table_name]
      end

      def next_migration_version
        if @migration_version_type == 'Timestamp'
          DateTime.now.strftime('%Y%m%d%H%M%S')
        else
          last_migration = 0
          length = 3
          Dir.glob("#{migration_output_path}/*.rb") do |rb_file|
            migration = File.basename(rb_file).split('_').first
            if migration.to_i > last_migration
              last_migration = migration.to_i
              length = migration.length
            end
          end

          (last_migration + 1).to_s.rjust(length, "0")
        end
      end
    end
  end
end
