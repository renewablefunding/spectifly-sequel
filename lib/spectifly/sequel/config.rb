module Spectifly
  module Sequel
    @valid_config_keys = [:migration_path, :entity_definition_path]
    @config = {}

    def self.configure_with(path_to_config_file)
      begin
        config = YAML.load_file(path_to_config_file)['Spectifly']['Sequel']
      rescue NoMethodError
        raise config_instructions
      end
      configure(config)
    end

    def self.configure(opts)
      opts.each {|k,v| @config[k.to_sym] = v if @valid_config_keys.include? k.to_sym}
    end

    def self.migration_path
      @config[:migration_path] or raise missing_configuration('migration_path')
    end

    def self.entity_definition_path
      @config[:entity_definition_path] or raise missing_configuration('entity_definition_path')
    end
private
    def self.config_instructions 
<<-INSTRUCTIONS
Please format config files in the following manner:
``- begin YAML
Sequel:
  Spectifly:
    migration_path: PATH_TO_MIGRATION_DIRECTORY
    entity_definition_path: PATH_TO_ENTITY_DEFINITION_DIRECTORY
``- end YAML
INSTRUCTIONS
    end

    def self.missing_configuration(config_param)
      "Spectify::Sequel is not configured properly. \"#{config_param}\" must be set via YAML or a hash."
    end
  end
end
