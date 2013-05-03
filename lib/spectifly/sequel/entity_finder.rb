module Spectifly
  module Sequel
    class EntityFinder
      def initialize path
        @path = path
      end

      def all
        entity_files = Dir[@path + '/*.entity']
        entity_files.sort.map do |f|
          entity = Spectifly::Entity.new(f)
        end
      end

    end
  end
end
