class Smashcut
  module FountainRules
    module Dialogue
      include Parslet

      rule(:spiral_character_name) do
        spiral >>
        anything_but("\n").as(:character_name)
      end

      rule(:no_spiral_character_name) do
        anything_but("a-z", "\n").as(:character_name)
      end

      rule(:character_name) do
        spiral_character_name | no_spiral_character_name
      end

      rule(:speech) do
        anything_but("\n").as(:speech)
      end

      rule(:dialogue) do
        (
          character_name >>
          line_break >>
          (
            parenthetical >>
            line_break
          ).maybe >>
          speech
        ).as(:dialogue)
      end

      rule(:parenthetical) do
        (
          opening_parenthesis >>
          anything_but(")") >>
          closing_parenthesis
        ).as(:parenthetical)
      end
    end
  end
end
