# It's nice to have this here, sometimes you want it!
require "pry"

# The gem!
require "smashcut"

# Some helpful rspec matchers from parslet
require "parslet/rig/rspec"

# Our helpers
Dir.glob("./spec/support/**/*.rb").each { |f| require f }

RSpec.configure do |config|
  # let's keep it fresh
  config.raise_errors_for_deprecations!

  # tests should pass in any order
  config.order = :random

  config.expect_with :rspec do |c|
    # TODO: switch over to expect
    c.syntax = :should
  end
end
