module Spectifly
  module Sequel
    class Configuration < Spectifly::Configuration
      VALID_CONFIG_KEYS = [:sequel_migration_path, :sequel_migration_version_type]

      attr_accessor :migration_path, :migration_version_type

      def initialize(config)
        if config.is_a? String
          config = YAML.load_file(config)
        end

        new_config = {}
        config.each { |k, v| new_config[k.to_s] = v }

        begin
          super new_config
          @migration_path = new_config.fetch('sequel_migration_path')
          @migration_version_type = get_version_type new_config['sequel_migration_version_type']
        rescue KeyError => e
          raise "Spectify::Sequel is not configured properly. \"#{e.message.sub(/"$/, '').sub(/^.*"/, '')}\" must be set via YAML or a hash."
        end
      end

      def get_version_type type
        if %w(Timestamp Integer).include? type.to_s
          type
        else
          'Timestamp'
        end
      end
    end
  end
end
