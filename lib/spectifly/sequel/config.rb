module Spectifly
  module Sequel
    @valid_config_keys = [:sequel_migration_path, :entity_path, :sequel_migration_version_type]
    @config = {}

    def self.configure_with(path_to_config_file)
      configure YAML.load_file(path_to_config_file)
    end

    def self.configure(opts)
      opts.each {|k,v| @config[k.to_sym] = v if @valid_config_keys.include? k.to_sym}
    end

    def self.migration_path
      @config[:sequel_migration_path] or raise missing_configuration('sequel_migration_path')
    end

    def self.entity_definition_path
      @config[:entity_path] or raise missing_configuration('entity_path')
    end

    def self.migration_version_type
      type = @config[:sequel_migration_version_type].to_s
      if %w(Timestamp Integer).include? type
        type
      else
        'Timestamp'
      end
    end

private
    def self.config_instructions 
<<-INSTRUCTIONS
Please format config files in the following manner:
``- begin YAML
sequel_migration_path: PATH_TO_MIGRATION_DIRECTORY
entity_path: PATH_TO_ENTITY_DEFINITION_DIRECTORY
``- end YAML
INSTRUCTIONS
    end

    def self.missing_configuration(config_param)
      "Spectify::Sequel is not configured properly. \"#{config_param}\" must be set via YAML or a hash."
    end
  end
end
