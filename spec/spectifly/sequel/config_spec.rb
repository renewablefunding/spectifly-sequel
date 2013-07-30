require 'spec_helper'

describe Spectifly::Sequel do
  let(:path_to_config_file) { File.join(base_fixture_path, 'config_file.yml') }
  let(:path_to_invalid_config_file) { File.join(base_fixture_path, 'invalid_config_file.yml') }
  let(:config_hash) {
    {
      'sequel_migration_path' => 'foo/bar/baz.yml',
      'entity_path' => 'blah/blah/',
      'sequel_migration_version_type' => 'Timestamp',
    }
  }
  let(:friendly_config_instructions) {
<<-INSTRUCTIONS
Please format config files in the following manner:
``- begin YAML
    sequel_migration_path: PATH_TO_MIGRATION_DIRECTORY
    entity_path: PATH_TO_ENTITY_DEFINITION_DIRECTORY
``- end YAML
INSTRUCTIONS
  }

  it 'should allow config to be read from yaml in a path specified by the user' do
    described_class.configure_with path_to_config_file
    described_class.migration_path.should == './spec/tmp/migrations/'
    described_class.entity_definition_path.should == './spec/fixtures/'
    described_class.migration_version_type.should == 'Integer'
  end

  it 'should accept a config in hash format' do
    described_class.configure config_hash
    described_class.migration_path.should == 'foo/bar/baz.yml'
    described_class.entity_definition_path.should == 'blah/blah/'
    described_class.migration_version_type.should == 'Timestamp'
  end

  it 'gives reasonable, instructive error if either path is not set' do
    described_class.configure({:sequel_migration_path => nil, :entity_path => nil, :sequel_migration_version_type => 'IDoNotKnow'})
    lambda {
      described_class.migration_path
    }.should raise_error('Spectify::Sequel is not configured properly. "sequel_migration_path" must be set via YAML or a hash.')
    lambda {
      described_class.entity_definition_path
    }.should raise_error('Spectify::Sequel is not configured properly. "entity_path" must be set via YAML or a hash.')
    described_class.migration_version_type.should == 'Timestamp'
  end

  it 'defaults to Timestamp migration versions if not set' do
    described_class.configure({:migration_version_type => nil})
    described_class.migration_version_type.should == 'Timestamp'
  end
end
