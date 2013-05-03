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

  describe '#to_new_column' do
    it 'returns a column definition with options for a required field' do
      field = described_class.new('Why am I required*')
      field.to_new_column.should == 'String :why_am_i_required, :null => false'
    end

    it 'returns a foreign key column definition if the type is appropriate to such things' do
      pending
      field = described_class.new('Group', {'Type' => 'Group'})
      field.to_new_column.should == 'foreign_key :group_id, :groups'
    end
  end
end
