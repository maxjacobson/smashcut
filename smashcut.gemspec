# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "smashcut/version"

Gem::Specification.new do |spec|
  spec.name          = "smashcut"
  spec.version       = Smashcut::VERSION
  spec.authors       = ["Max Jacobson"]
  spec.email         = ["max@hardscrabble.net"]
  spec.summary       = "Parse screenplays with Ruby"
  spec.description   = "Parse screenplays with Ruby"
  spec.homepage      = "https://github.com/maxjacobson/smashcut"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "parslet", "~> 1.7"
  spec.add_runtime_dependency "prawn", "~> 2.0"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.3"
  spec.add_development_dependency "rubocop", "~> 0.34"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "yard"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "guard-rubocop"

  spec.required_ruby_version = ">= 2.2.0"
end
