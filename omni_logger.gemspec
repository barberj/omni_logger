# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omni_logger/version'

Gem::Specification.new do |spec|
  spec.name          = "omni_logger"
  spec.version       = OmniLogger::VERSION
  spec.authors       = ["barberj"]
  spec.email         = ["barber.justin@gmail.com"]

  spec.summary       = %q{Log all the things.}
  spec.description   = %q{Log to multiple locations.}
  spec.homepage      = "https://github.com/barberj/omni_logger"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"

  spec.add_runtime_dependency "logger"
end
