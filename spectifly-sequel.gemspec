# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'spectifly/sequel/version'

Gem::Specification.new do |spec|
  spec.name          = "spectifly-sequel"
  spec.version       = Spectifly::Sequel::VERSION
  spec.authors       = ["Maher Hawash","Ravi Gadad", "Laurie Kemmerer", "David Miller"]
  spec.email         = ["mhawash@renewfund.com", "ravi@renewfund.com", "laurie@renewfund.com", "dave.miller@renewfund.com"]
  spec.description   = %q{An add-on to the Spectifly gem that generates Sequel migrations andd models based on Spectifly}
  spec.summary       = %q{A Sequel add-on to Spectifly https://github.com/renewablefunding/spectifly}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "spectifly"
  spec.add_runtime_dependency "sequel"
  spec.add_runtime_dependency "activesupport"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "debugger"
end
