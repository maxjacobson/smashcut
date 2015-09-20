require "parslet"

module Smashcut
  # This class parses fountain text and annotates what it finds
  # Meant to be used in conjunction with {FountainTransform}, which transforms
  # that annotated input into a rich {Screenplay} object.
  class FountainParser < Parslet::Parser
    # entry-point to the parser
    root(:screenplay)

    # screenplay is a bunch of elements spaced out with 2 linebreaks
    # TODO: maybe it should be 2-or-more linebreaks
    rule(:screenplay) do
      (screenplay_element >>
       line_break.maybe >>
       line_break.maybe).repeat(1).as(:screenplay)
    end

    # these are all the different parts that make up a screenplay
    rule(:screenplay_element) do
      scene_heading | dialogue | action
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
    rule(:star) { str("*") }

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
      (opening_parenthesis >>
       anything_but(")") >>
       closing_parenthesis).as(:parenthetical)
    end

    # this is kind of a catch-all rule. it should just be one line.
    # TODO: but... what if the writer uses line breaks for wrapping?
    # I think that's officially supported, so we should respect that
    rule(:action) do
      (italicized_phrase | plain_phrase).repeat(1).as(:action)
    end

    rule(:plain_phrase) { anything_but("\n").as(:plain) }

    rule(:italicized_phrase) do
      star >> anything_but("\n", "*").as(:italicized) >> star
    end

    private

    def anything_but(*chars)
      match["^#{chars.join}"].repeat(1)
    end
  end
end
