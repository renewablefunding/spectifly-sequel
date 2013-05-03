require 'sequel'
module Spectifly
  module Sequel
    class Types
      Native = ::Sequel::Schema::CreateTableGenerator::GENERIC_TYPES.map { |type| type.to_s }

      Extended = {
        'percent' => {
          'Type' => 'Numeric',
        },
        'currency' => {
          'Type' => 'Numeric',
        },
        'year' => {
          'Type' => 'Integer'
        },
      }

      All = Native + Extended.map { |k, v| v['Type'] }
    end
  end
end
