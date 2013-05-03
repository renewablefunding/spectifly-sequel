require 'spec_helper'
require_relative '../../../lib/spectifly/sequel/model'

describe Spectifly::Sequel::Model do
  describe '#table_name' do
    def model_for(entity_type)
      entity = Spectifly::Entity.new(fixture_path(entity_type))
      described_class.new(entity)
    end

    it 'pluralizes and tokenizes an entity\'s root' do
      model_for('individual').table_name.should == 'individuals'
      
      model_for('goose').table_name.should == 'geese'
    end
  end

  describe '.all' do
    it 'returns the name of all the entity defintions in a path' do
      described_class.all(base_fixture_path).map(&:to_s).should == %w(Goose Group Individual)
    end
  end
end
