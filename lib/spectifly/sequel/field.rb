module Spectifly
  module Sequel
    class Field < Spectifly::Field
      def type
        Spectifly::Support.camelize(super)
      end

      def to_new_column
        options = []
        options << ':null => false' if required?
        options << ':unique => true' if unique?
        "#{type} :#{name}#{!options.empty? ? ', ' + options.join(', ') : ''}"
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
