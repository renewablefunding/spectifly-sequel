module Spectifly
  module Sequel
    class Field < Spectifly::Field
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

      def unique?
        restrictions['unique'] == true
      end

      def extract_restrictions
        super
        unique_validation = validations.any? { |v| v =~ /must be unique/i }
        unique_attribute = attributes.delete("Unique")
        if (unique_validation && unique_attribute.nil?) ^ (unique_attribute.to_s == "true")
          @restrictions['unique'] = true
        elsif unique_validation && !["true", ""].include?(unique_attribute.to_s)
          raise "Field #{name} has contradictory information about uniqueness."
        end
      end
    end
  end
end
