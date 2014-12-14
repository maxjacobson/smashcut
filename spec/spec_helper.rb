if ENV['BLINK_182_DRUMMER'] == 'TRAVIS'
  require "codeclimate-test-reporter"
  CodeClimate::TestReporter.start
end

require 'smashcut'
require 'parslet/rig/rspec'
require 'smashcut/parslet_debug' unless ENV['QUIET'] == 'true'

def read_fountain(file)
  filename = File.expand_path "./spec/screenplays/" + file.gsub(" ", "_") + ".fountain"
  File.read filename
end

RSpec.configure do |config|
  config.raise_errors_for_deprecations!
  config.expect_with :rspec do |c|
    c.syntax = :should
  end
end
