require 'spec_helper'

describe Spectifly::Sequel::Configuration do
  let(:path_to_config_file) { File.join(base_fixture_path, 'config_file.yml') }
  let(:config_hash) {
    {
      'sequel_migration_path' => 'foo/bar/baz.yml',
      'entity_path' => 'blah/blah/',
      'sequel_migration_version_type' => 'Timestamp',
    }
  }

  it 'should allow config to be read from yaml in a path specified by the user' do
    subject = described_class.new path_to_config_file
    subject.migration_path.should == './spec/tmp/migrations/'
    subject.entity_path.should == './spec/fixtures/'
    subject.migration_version_type.should == 'Integer'
  end

  it 'should accept a config in hash format' do
    subject = described_class.new config_hash
    subject.migration_path.should == 'foo/bar/baz.yml'
    subject.entity_path.should == 'blah/blah/'
    subject.migration_version_type.should == 'Timestamp'
  end

  it 'gives reasonable, instructive error if either path is not set' do
    lambda {
      described_class.new(:entity_path => 'foo')
    }.should raise_error('Spectify::Sequel is not configured properly. "sequel_migration_path" must be set via YAML or a hash.')

    lambda {
      described_class.new(:sequel_migration_path => 'bar')
    }.should raise_error('Spectify::Sequel is not configured properly. "entity_path" must be set via YAML or a hash.')

    described_class.
      new(config_hash.merge({:sequel_migration_version_type => 'bsadfklj'})).
      migration_version_type.should == 'Timestamp'
  end

  it 'defaults to Timestamp migration versions if not set' do
    subject = described_class.new(config_hash.merge({:sequel_migration_version_type => nil}))
    subject.migration_version_type.should == 'Timestamp'
  end
end
