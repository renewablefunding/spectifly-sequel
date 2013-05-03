require 'erb'
module Spectifly
  module Sequel
    class Builder < Spectifly::Builder
      attr_accessor :entity_names, :model
      def initialize(entity, options = {})
        super(entity, options)
        @entity_names = Spectifly::Sequel::EntityFinder.new(File.dirname(entity.path)).all.map(&:root)
        @model = Spectifly::Sequel::Model.new(entity)
      end

      def field_class
        Spectifly::Sequel::Field
      end

      def build
        migration ||= migration_erb
      end

      private
        def migration_erb
          field_definitions = ERB.new <<-EOF.strip
<% fields.each do |field| %>
      <%= field.for_new_migration(entity_names) %><% end %>
EOF
          template = ERB.new <<-EOF
Sequel.migration do
  change do
    create_table(:#{@model.table_name}) do
      primary_key :id#{field_definitions.result(binding)}
    end
  end
end
EOF
          template.result(binding)
        end
    end
  end
end
