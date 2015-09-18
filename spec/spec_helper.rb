# It's nice to have this here, sometimes you want it!
require "pry"

# The gem!
require "smashcut"

# Some helpful rspec matchers from parslet
require "parslet/rig/rspec"

# Our helpers
Dir.glob("./spec/support/**/*.rb").each { |f| require f }

RSpec.configure do |config|
  config.raise_errors_for_deprecations!
  config.disable_monkey_patching!
  config.order = :random
end
