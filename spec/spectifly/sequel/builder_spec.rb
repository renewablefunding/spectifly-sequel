require 'spec_helper'
require 'json'

describe Spectifly::Sequel::Builder do
  describe '.build' do
    it 'works for a simple case' do
      path_builder = Spectifly::Sequel::Builder.from_path(fixture_path('group'))
      migration_path = expectation_path('group')
      migration = path_builder.build
      migration.should == File.read(migration_path)
    end

    it 'works for associations' do
      pending
      path_builder = Spectifly::Sequel::Builder.from_path(fixture_path('individual'))
      migration_path = expectation_path('individual')
      migration = path_builder.build
      migration.should == File.read(migration_path)
    end
  end
end
