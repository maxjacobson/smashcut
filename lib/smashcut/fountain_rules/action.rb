class Smashcut
  module FountainRules
    module Action
      include Parslet

      rule(:action) do
        scene_openers.absent? >>
          anything_but("\n").as(:action)
      end
    end
  end
end
