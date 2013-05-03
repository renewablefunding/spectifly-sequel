require 'erb'
module Spectifly
  module Sequel
    class Builder < Spectifly::Builder
      def field_class
        Spectifly::Sequel::Field
      end

      def build
        migration ||= migration_erb
      end

      def initialize(entity, options={})
        super(entity, options)
        @model = Spectifly::Sequel::Model.new(@entity)
      end

      private
        def migration_erb
          field_definitions = ERB.new <<-EOF.strip
<% fields.each do |field| %>
      <%= field.to_new_column %><% end %>
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
