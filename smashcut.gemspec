# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'smashcut/version'

Gem::Specification.new do |spec|
  spec.name          = "smashcut"
  spec.version       = Smashcut::VERSION
  spec.authors       = ["Max Jacobson"]
  spec.email         = ["max@hardscrabble.net"]
  spec.summary       = %q{Parse screenplays with Ruby}
  spec.description   = %q{Parse screenplays with Ruby}
  spec.homepage      = "https://github.com/maxjacobson/smashcut"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.0.0.rc1"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "awesome_print"

  spec.add_runtime_dependency "parslet", "~> 1.6"

  spec.required_ruby_version = '>= 1.9.3'
end
