module Spectifly
  module Sequel
    class FieldForMigration
      attr_accessor :field_name, :field_type, :options, :model

      def initialize(field, model, entity_references)
        @field = field
        @field_name = field.name
        @field_type = field.type
        @model = model
        @options = retrieve_options(field)
      end

      def retrieve_options(field)
        options = []
        options << ':null => false' if field.required?
        options << ':unique => true' if field.unique?
        options
      end

      def render
        template = if single_value_simple_type?
                     'single_value_simple_type_field'
                   elsif multiple_value_simple_type?
                     'multiple_value_simple_type_field'
                   end
        return if template.nil?

        path = File.expand_path(File.join(*File.dirname(__FILE__), 'erb', 'field', "#{template}.erb"))
        content = File.read(path)
        t = ERB.new(content, nil, '-')
        t.filename = path
        t.result(binding)
      end

      def single_value_simple_type?
        @model_for_field.nil? && !@field.multiple?
      end

      def multiple_value_simple_type?
        @model_for_field.nil? && @field.multiple?
      end
    end
  end
end
