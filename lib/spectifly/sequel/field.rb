module Spectifly
  module Sequel
    class Field < Spectifly::Base::Field
      def type
        field_type = super
        if base_type = Spectifly::Sequel::Types::Extended[field_type]
          field_type = base_type['Type']
        end

        Spectifly::Support.camelize(field_type)
      end

      # The entity_references param is the list of entity namesthat the caller
      # knows about.  This lets us figure out whether the field should actually
      # be the id of the entity/model being referenced by the field type.
      def for_new_migration(model, entity_references = [])
        @field_for_migration = Spectifly::Sequel::FieldForMigration.new(self, model, entity_references)
        @field_for_migration.render
      end
    end
  end
end
