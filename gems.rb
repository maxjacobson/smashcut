# frozen_string_literal: true
source "https://rubygems.org"

gem "bundler", "~> 1.11"
gem "codeclimate-test-reporter", :group => :test, :require => nil
gem "rake", "~> 11.0"
gem "rspec", "~> 3.4"
# TODO(#shipit): bring back rubocop-rspec
gem "rubocop", "0.46"
gem "todo_lint"
gem "yard"

group :development do
  gem "guard"
  gem "guard-rspec"
  gem "guard-rubocop"
end

# Specify your gem's dependencies in smashcut.gemspec
gemspec
