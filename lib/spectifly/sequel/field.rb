module Spectifly
  module Sequel
    class Field < Spectifly::Field
      def type
        Spectifly::Support.camelize(super)
      end


      # The entity_references param is the list of entity namesthat the caller
      # knows about.  This lets us figure out whether the field should actually
      # be the id of the entity/model being referenced by the field type.
      def for_new_migration(model, entity_references = [])
        options = []
        options << ':null => false' if required?
        options << ':unique => true' if unique?
        options_string = !options.empty? ? ', ' + options.join(', ') : ''
        if entity_references.include?(type)
          "Integer :#{name}_id#{options_string}"
        elsif multiple?
          association_table = "#{model.table_name}_#{name}"
          <<-EOF
    create_table(:#{association_table}) do
      primary_key :id
      foreign_key :#{model.name_as_foreign_key}, :#{model.table_name}, :null => false
      #{type} :name, :null => false
    end

    add_index [:#{model.name_as_foreign_key}, :name], :#{association_table}, :unique => true
          EOF
        else
          "#{type} :#{name}#{options_string}"
        end
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
