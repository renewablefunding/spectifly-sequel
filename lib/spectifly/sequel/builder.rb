require 'erb'
module Spectifly
  module Sequel
    class Builder < Spectifly::Builder
      attr_accessor :entity_names, :model
      def initialize(entity, options = {})
        super(entity, options)
        @entity_names = Spectifly::Sequel::EntityFinder.new(File.dirname(entity.path)).all.map(&:root)
        @model = Spectifly::Sequel::Model.new(entity, fields)
      end

      def field_class
        Spectifly::Sequel::Field
      end

      def build
        migration ||= migration_erb
      end

      private
        def migration_erb
          template_path = File.join(*File.dirname(__FILE__), 'erb', 'new_migration.erb')
          render template_path
        end

        def render path
          content = File.read(File.expand_path(path))
          t = ERB.new(content)
          t.filename = File.expand_path(path)
          t.result(binding)
        end
    end
  end
end
