require 'spectifly'
require_relative '../lib/spectifly/sequel'

def spec_path
  File.dirname(__FILE__)
end

def migration_output_path
  File.join(spec_path, 'tmp', 'migrations')
end

def base_expectation_path
  File.join(spec_path, 'expectations')
end

def expectation_path(expectation)
  File.join(base_expectation_path, "#{expectation}.migration")
end

def base_fixture_path
  File.join(spec_path, 'fixtures')
end

def fixture_path(fixture)
  File.join(base_fixture_path, "#{fixture}.entity")
end
