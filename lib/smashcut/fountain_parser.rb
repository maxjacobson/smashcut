require "parslet"

module Smashcut
  # This class parses fountain text and annotates what it finds
  # Meant to be used in conjunction with {FountainTransform}, which transforms
  # that annotated input into a rich {Screenplay} object.
  class FountainParser < Parslet::Parser
    # entry-point to the parser
    root(:screenplay)
    rule(:screenplay) do
      (screenplay_element >>
       line_break.maybe >>
       line_break.maybe).repeat(1).as(:screenplay)
    end

    # simple rules
    rule(:line_break) { str("\n") }
    rule(:dot) { str(".") }
    rule(:space) { str(" ") }
    rule(:hash) { str('#') }
    rule(:bang) { str("!") }
    rule(:spiral) { str("@") }
    rule(:opening_parenthesis) { str("(") }
    rule(:closing_parenthesis) { str(")") }

    # TODO: explain what is happening here
    rule(:scene_openers) do
      %w( i/e int/ext int./ext ext int est ).map do |opener|
        opener.split("").map do |char|
          match["#{char.downcase}#{char.upcase}"]
        end.reduce(:>>)
      end.reduce(:|)
    end

    rule(:scene_number) do
      space.maybe >> hash >> anything_but("#").as(:scene_number) >> hash
    end

    rule(:anything_but_scene_number) do
      anything_but("#", "\n")
    end

    rule(:leading_dot_scene_heading) do
      dot >> anything_but_scene_number.as(:scene_heading) >> scene_number.maybe
    end

    rule(:whitelisted_scene_openers_scene_heading) do
      (scene_openers >> dot.maybe >> space >> anything_but_scene_number)
        .as(:scene_heading) >> scene_number.maybe
    end

    rule(:scene_heading) do
      leading_dot_scene_heading | whitelisted_scene_openers_scene_heading
    end

    rule(:spiral_character_name) do
      spiral >> anything_but("\n").as(:character_name)
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
      (character_name >> line_break >>
        (parenthetical >> line_break).maybe >> speech).as(:dialogue)
    end

    rule(:parenthetical) do
      (
        opening_parenthesis >>
        anything_but(")") >>
        closing_parenthesis
      ).as(:parenthetical)
    end

    rule(:action) do
      scene_openers.absent? >> anything_but("\n").as(:action)
    end

    rule(:screenplay_element) do
      scene_heading | dialogue | action
    end

    private

    def anything_but(*chars)
      match["^#{chars.join}"].repeat(1)
    end
  end
end
