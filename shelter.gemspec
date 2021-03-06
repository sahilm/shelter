# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'shelter/version'

Gem::Specification.new do |spec|
  spec.name          = "shelter"
  spec.version       = Shelter::VERSION
  spec.authors       = ["Sahil Muthoo"]
  spec.email         = ["sahil.muthoo@gmail.com"]
  spec.description   = %q{A shell example in Ruby}
  spec.summary       = %q{A shell example in Ruby}
  spec.homepage      = "https://github.com/sahilm/shelter"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
