module Spectifly
  module Sequel
    class Model
      attr_accessor :table_name, :display_name, :single_value_fields, :multiple_value_fields, :model_name, :name_as_foreign_key

      def initialize(entity, fields)
        @entity = entity
        @display_name = entity.root
        @fields = fields
        @model_name = Spectifly::Support.camelize(display_name)
        @table_name = Spectifly::Support.tokenize(ActiveSupport::Inflector.pluralize(display_name))
        @name_as_foreign_key = Spectifly::Support.tokenize(display_name) + '_id'
        @single_value_fields = fields.select { |f| !f.multiple? }
        @multiple_value_fields = fields.select { |f| f.multiple? }
      end
    end
  end
end
