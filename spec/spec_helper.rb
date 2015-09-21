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

  # let's work for it
  config.disable_monkey_patching!

  # let's make our tests pass in any order
  config.order = :random

  # enables `bundle exec rspec --only-failure` for reruns
  config.example_status_persistence_file_path = "rspec.results"

  # allow to focus on one thing at a time if you like, by adding the focus tag
  config.filter_run_including :focus => true
  config.run_all_when_everything_filtered = true
end
