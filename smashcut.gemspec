# coding: utf-8
# frozen_string_literal: true
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
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.test_files = []
  spec.require_paths = ["lib"]

  spec.add_dependency "parslet", "~> 1.7"
  spec.add_dependency "prawn", "~> 2.0"

  # to get required keyword arguments
  spec.required_ruby_version = ">= 2.1.0"
end
