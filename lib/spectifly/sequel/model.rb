module Spectifly
  module Sequel
    class Model
      require 'linguistics'
      Linguistics.use( :en, :classes => [self] )

      def initialize(entity)
        @entity = entity
      end

      class << self
        def all(path=nil)
          entity_files = Dir[path + '/*.entity']
          entity_files.sort.map do |f|
            entity = Spectifly::Entity.new(f)
            new(entity)
          end
        end
      end

      def to_s
        Spectifly::Support.camelize(@entity.root)
      end

      def table_name
        Spectifly::Support.tokenize(self.en.plural)
      end
    end
  end
end
