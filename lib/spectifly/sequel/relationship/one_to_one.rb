module Spectifly
  module Sequel
    module Relationship
      class OneToOne < Base
        attr_accessor :field_name, :table_name, :required, :unique

        def initialize(name, attributes, related_entity)
          super
          @table_name = Spectifly::Support.tokenize(ActiveSupport::Inflector.pluralize(@entity.type))
          @field_name = Spectifly::Support.tokenize(@entity.name) + '_id'
          @required = @entity.required?
          @unique = @entity.unique?
        end
      end
    end
  end
end
