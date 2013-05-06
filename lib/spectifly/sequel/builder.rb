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
        template_path = File.join(*File.dirname(__FILE__), 'erb', 'new_migration.erb')
        render template_path
      end

      private
        def render path
          content = File.read(File.expand_path(path))
          t = ERB.new(content, nil, '-') # third param lets us use trim
          t.filename = File.expand_path(path)
          t.result(binding)
        end
    end
  end
end
