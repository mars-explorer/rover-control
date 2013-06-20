# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rover/control/version'

Gem::Specification.new do |spec|
  spec.name          = "rover-control"
  spec.version       = Rover::Control::VERSION
  spec.authors       = ["David Rouchy"]
  spec.email         = ["drouchy@gmail.com"]
  spec.description   = %q{Mars rover control exercise}
  spec.summary       = %q{Mars rover control exercise}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.13.0"
  spec.add_development_dependency "cucumber", "~> 1.3.2"
  spec.add_development_dependency "json", "~> 1.8.0"
end
