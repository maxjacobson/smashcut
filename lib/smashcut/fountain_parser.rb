require "parslet"
require "smashcut/fountain_rules"

class Smashcut
  class FountainParser < Parslet::Parser
    include FountainRules

    root(:screenplay)

    rule(:screenplay) do
      (
        screenplay_element >>
        line_break.maybe >>
        line_break.maybe
      ).repeat(1)
    end

    rule(:screenplay_element) do
      scene_heading |
      dialogue |
      action
    end

  end
end

