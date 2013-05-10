module Spectifly
  module Sequel
    class Model
      attr_accessor :table_name, :display_name, :model_name,
        :single_value_fields, :multiple_value_fields,
        :has_and_belong_to_many, :name_as_foreign_key,
        :foreign_keys

      def initialize(entity, fields)
        @display_name = entity.root
        @model_name = Spectifly::Support.camelize(display_name)
        @table_name = Spectifly::Support.tokenize(ActiveSupport::Inflector.pluralize(display_name))

        @single_value_fields = fields.select { |f| !f.multiple? }
        @multiple_value_fields = fields.select { |f| f.multiple? }

        @name_as_foreign_key = Spectifly::Support.tokenize(display_name) + '_id'
        get_relationships(entity)
      end

      def get_relationships(entity)
        @foreign_keys = []
        @has_and_belong_to_many = []
        entity.relationships.each do |relationship_type, rels|
          camelized_type = Spectifly::Support.camelize(relationship_type)
          rels.each do |name, attributes|
            if %w(BelongsTo HasOne HasA).include? camelized_type
              relation = create_relation(camelized_type, name, attributes, entity)
              @foreign_keys << relation
            elsif %(BelongsToMany HasAndBelongsToMany HasMany).include?(camelized_type)
              relation = create_relation(camelized_type, name, attributes, entity)
              # as long as the has_many has a coinciding belongs_to_many and the association table makes sense...
              if relation.multiple_related_entity? && !(@name_as_foreign_key == relation.field_name && @table_name == relation.table_name)
                @has_and_belong_to_many << relation
              end
            end
          end
        end
      end

      def create_relation(type, name, attributes, entity)
        relationship_class = ActiveSupport::Inflector.constantize('Spectifly::Sequel::Relationship::%s' % type)
        relation = relationship_class.new(name, attributes, entity)
      end
    end
  end
end
