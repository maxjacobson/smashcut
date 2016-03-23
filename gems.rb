# frozen_string_literal: true
source "https://rubygems.org"

gem "bundler", "~> 1.11"
gem "rake", "~> 11.0"
gem "rspec", "~> 3.4"
# TODO(#shipit): bring back rubocop-rspec
gem "rubocop"
gem "yard"
gem "guard"
gem "guard-rspec"
gem "guard-rubocop"
gem "todo_lint"

# Specify your gem's dependencies in smashcut.gemspec
gemspec
