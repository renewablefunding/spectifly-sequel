require 'spec_helper'
require_relative '../../../lib/spectifly/sequel/field'

describe Spectifly::Sequel::Field do
  describe '#type' do
    it 'defaults to String if no type is given' do
      field = described_class.new('I cannot spell rhubarb')
      field.type.should == 'String'
    end

    it 'returns Boolean if field has ? token' do
      field = described_class.new('Can I spell misspelled?')
      field.type.should == 'Boolean'
    end
  end

  describe 'uniqueness restriction' do
    it 'unique should be false by default and there should be no unique restriction' do
      field = described_class.new("Mini me")
      field.should_not be_unique
      field.restrictions.keys.should_not be_include('unique')
    end

    it 'adds a restriction and returns true for unique? if there is a uniqueness validation' do
      field = described_class.new("Little Snowflake", {"Validations" => "must be unique"})
      field.should be_unique
      field.restrictions.keys.include?('unique').should be_true
    end

    it 'adds a restriction and returns true for unique? if there is an attribute Unique set to true' do
      field = described_class.new("Little Snowflake", {"Unique" => "true"})
      field.should be_unique
      field.restrictions.keys.include?('unique').should be_true
    end

    it 'throws an error if the two ways of setting uniqueness contradict each other' do
      lambda {
      field = described_class.new("Little Snowflake?", {"Validations" => "must be unique", "Unique" => false})
      }.should raise_error
    end
  end

  describe '#for_new_migration' do
    Model = Struct.new(:entity_name, :table_name, :name_as_foreign_key)
    let(:individual_model) { Model.new('individual', 'individuals', 'individual_id') }
    it 'returns a column definition with options for a required field' do
      field = described_class.new('Why am I required*')
      field.for_new_migration(individual_model).should == 'String :why_am_i_required, :null => false'
    end

    it 'returns a reference to another table if there is an entity with the same name as the type' do
      field = described_class.new('Group', {'Type' => 'Group'})
      field.for_new_migration(individual_model, ['Group', 'Individual']).should == 'Integer :group_id'
    end

    it 'returns a basic association table for a field with multiple native-type values' do
      field = described_class.new('Animals',  {'Valid Values' => ['Giraffe', 'Puffin', 'Dog'], 'Multiple' => true})
      field.for_new_migration(individual_model, []).should == File.read(expectation_path('animal_multiple_value_string_field'))
    end
  end
end
