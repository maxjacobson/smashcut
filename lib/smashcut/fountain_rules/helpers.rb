class Smashcut
  module FountainRules
    module Helpers
      include Parslet

      def anything_but(*chars)
        match["^#{chars.join}"].repeat(1)
      end

    end
  end
end
