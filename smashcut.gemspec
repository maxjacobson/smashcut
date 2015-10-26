# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "smashcut/version"

Gem::Specification.new do |spec|
  spec.name = "smashcut"
  spec.version = Smashcut::VERSION
  spec.authors = ["Max Jacobson"]
  spec.email = ["max@hardscrabble.net"]
  spec.summary = "Parse screenplays with Ruby"
  spec.description = "Parse screenplays with Ruby"
  spec.homepage = "https://github.com/maxjacobson/smashcut"
  spec.license = "MIT"

  spec.files = `git ls-files -z`.split("\x0").reject { |f| f =~ /^spec/ }
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.test_files = []
  spec.require_paths = ["lib"]

  spec.add_dependency "parslet", "~> 1.7"
  spec.add_dependency "prawn", "~> 2.0"
  spec.add_dependency "required_arg", "~> 1.0"

  spec.required_ruby_version = ">= 2.0.0"
end
