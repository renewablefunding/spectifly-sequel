module Spectifly
  module Sequel
    class FieldForMigration
      attr_accessor :field_name, :field_type, :options, :model

      def initialize(field, model, entity_references)
        @field = field
        @field_name = field.name
        @field_type = field.type
        @model = model
        if entity = entity_references.detect { |e| e.root == field.type }
          builder = Spectifly::Sequel::Builder.new(entity)
          @model_for_field =  Spectifly::Sequel::Model.new entity, builder.fields
        end
        @options = retrieve_options(field)
        @field_as_foreign_key = ActiveSupport::Inflector.singularize(field.name) + '_id'
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
                   elsif single_value_entity?
                     'single_value_entity_field'
                   elsif multiple_value_simple_type?
                     'multiple_value_simple_type_field'
                   elsif many_to_many_association?
                     'many_to_many_association'
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

      def single_value_entity?
        !@model_for_field.nil? && !@field.multiple?
      end

      def multiple_value_simple_type?
        @model_for_field.nil? && @field.multiple?
      end

      def many_to_many_association?
        !@model_for_field.nil? && @field.multiple? &&
          # and the model being referenced has an attribute for the current model 
          # and that model is multi-value (aka many-to-many rather than one to many)
          @model_for_field.multiple_value_fields.map { |f| f.type }.include?(@model.display_name)
      end
    end
  end
end
