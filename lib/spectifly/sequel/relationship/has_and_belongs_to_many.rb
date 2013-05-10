module Spectifly
  module Sequel
    module Relationship
      class HasAndBelongsToMany < Base
        attr_accessor :field_name, :table_name, :many_to_many_table_name

        def initialize(name, attributes, related_entity)
          super
          related_table_name = Spectifly::Support.tokenize(ActiveSupport::Inflector.pluralize(related_entity.root))
          @field_name = Spectifly::Support.tokenize(ActiveSupport::Inflector.singularize(@entity.name)) + '_id'
          @table_name = Spectifly::Support.tokenize(ActiveSupport::Inflector.pluralize(@entity.type))
          @many_to_many_table_name = [related_table_name, Spectifly::Support.tokenize(@entity.name)].sort.join('_')
        end

        def multiple_related_entity?
          true
        end
      end
    end
  end
end
