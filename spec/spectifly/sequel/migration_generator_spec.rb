require 'spec_helper'

describe Spectifly::Sequel::MigrationGenerator do
  before :each do
    Spectifly::Sequel.configure_with File.join(base_fixture_path, 'config_file.yml')
    cleanup_files
  end

  after :each do
    cleanup_files
  end

  def cleanup_files
    Dir.glob("#{migration_output_path}/*.rb") do |rb_file|
      File.delete(rb_file)
    end
  end

  it 'reads a Spectifly entity definition file and outputs a migration that can generate a new table for that entity' do
    generator = Spectifly::Sequel::MigrationGenerator.new('individual')
    generator.run!
    expected_migration_path = File.join(migration_output_path, '001_create_individuals.rb')
    File.should exist(expected_migration_path)
    File.read(expected_migration_path).should == File.read(expectation_path('individual'))
  end

  it 'determines what the next migration version should be' do
    File.open(File.join(migration_output_path, '001_create_cookies.rb'), 'w') { |f| f.write('Hi!') }

    generator = Spectifly::Sequel::MigrationGenerator.new('individual')
    generator.run!

    expected_migration_path = File.join(migration_output_path, '002_create_individuals.rb')
    File.should exist(expected_migration_path)
  end

  it 'uses current datetime if user is assigning timestamps' do
    DateTime.stub(:now).and_return DateTime.new(2013,01,01)
    generator = Spectifly::Sequel::MigrationGenerator.new('individual', migration_output_path, base_fixture_path, 'Timestamp')
    generator.run!

    expected_migration_path = File.join(migration_output_path, '20130101000000_create_individuals.rb')
    File.should exist(expected_migration_path)
  end
end
