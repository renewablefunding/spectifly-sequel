module Spectifly
  module Sequel
    module Relationship
      class Base
        attr_accessor :entity, :related_entity

        def initialize(name, attributes, related_entity)
          @entity = Spectifly::Base::EntityNode.new(name, attributes)
          @related_entity = related_entity
        end
      end
    end
  end
end
