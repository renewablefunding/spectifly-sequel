require 'spec_helper'
require_relative '../../../lib/spectifly/sequel/types'

describe Spectifly::Sequel::Types do
  describe 'Native types' do
    it 'includes String, DateTime, Integer, Numeric, etc' do
      (%w(String DateTime Integer Numeric) - Spectifly::Sequel::Types::Native).should == []
    end
  end
end
