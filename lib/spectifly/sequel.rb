require 'active_support/inflector/methods'
require 'spectifly'
require_relative 'sequel/config'
require_relative 'sequel/types'
require_relative 'sequel/model'
require_relative 'sequel/tasks'
require_relative 'sequel/relationship/base'
require_relative 'sequel/relationship/one_to_one'
require_relative 'sequel/relationship/belongs_to'
require_relative 'sequel/relationship/has_and_belongs_to_many'
require_relative 'sequel/relationship/belongs_to_many'
require_relative 'sequel/relationship/has_a'
require_relative 'sequel/relationship/has_one'
require_relative 'sequel/relationship/has_many'
require_relative 'sequel/field'
require_relative 'sequel/field_for_migration'
require_relative 'sequel/builder'
require_relative 'sequel/migration_generator'
require_relative 'sequel/version'

module Spectifly
  module Sequel
  end
end
