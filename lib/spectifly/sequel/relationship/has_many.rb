module Spectifly
  module Sequel
    module Relationship
      class HasMany < HasAndBelongsToMany
        def multiple_related_entity?
          related_entity = Spectifly::Entity.from_directory(File.dirname(@related_entity.path))[@entity.type]
          (related_entity.relationships['Belongs To Many'] || {}).any? { |rel_name, attrs| attrs['Type'] == @related_entity.root }
        end
      end
    end
  end
end
