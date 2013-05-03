module Spectifly
  module Sequel
    class Model
      require 'linguistics'
      Linguistics.use( :en, :classes => [self] )

      attr_accessor :table_name, :display_name, :single_value_fields, :multiple_value_fields, :model_name

      def initialize(entity, fields)
        @entity = entity
        @display_name = entity.root
        @fields = fields
        @model_name = Spectifly::Support.camelize(display_name)
        @table_name = Spectifly::Support.tokenize(self.en.plural)
        @single_value_fields = fields.select { |f| !f.multiple? }
        @multiple_value_fields = fields.select { |f| f.multiple? }
      end

      def to_s
        display_name
      end
    end
  end
end
