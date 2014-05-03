require 'smashcut'
require 'parslet/rig/rspec'

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
