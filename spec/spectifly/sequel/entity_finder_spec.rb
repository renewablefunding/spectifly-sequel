require 'spec_helper'

describe Spectifly::Sequel::EntityFinder do
  describe '#all' do
    it 'returns the name of all the entity defintions in a path' do
      finder = described_class.new(base_fixture_path)
      finder.all.map(&:root).should == %w(Cow Group Individual)
    end
  end
end
