require "parslet"

class Smashcut
  class FountainParser < Parslet::Parser

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

    rule(:line_break) do
      str("\n")
    end

    rule(:dot) do
      str('.')
    end

    rule(:space) do
      str(' ')
    end

    rule(:hash) do
      str('#')
    end

    rule(:bang) do
      str('!')
    end

    rule(:spiral) do
      str('@')
    end

    rule(:opening_parenthesis) do
      str("(")
    end

    rule(:closing_parenthesis) do
      str(")")
    end

    rule(:leading_dot_scene_heading) do
      dot >>
      (
        match("[a-zA-Z\s\-]").repeat(1)
      ).as(:scene_heading) >>
      scene_number.maybe
    end

    rule(:scene_openers) do
      %w{ i/e int/ext int./ext ext int est }.map do |opener|
        opener.split('').map do |char|
          match["#{char.downcase}#{char.upcase}"]
        end.reduce(:>>)
      end.reduce(:|)
    end

    rule(:whitelisted_scene_openers_scene_heading) do
      (
        scene_openers >>
        dot.maybe >>
        space >>
        match("[a-zA-Z\s\-]").repeat(1)
      ).as(:scene_heading) >>
      scene_number.maybe
    end

    rule(:scene_number) do
      space.maybe >>
      hash >>
      match('[0-9a-zA-z\.\-]').repeat(1).as(:scene_number) >>
      hash
    end

    rule(:scene_heading) do
      leading_dot_scene_heading | whitelisted_scene_openers_scene_heading
    end

    rule(:spiral_character_name) do
      spiral >>
      match("[A-Za-z ]").repeat(1).as(:character_name)
    end

    rule(:no_spiral_character_name) do
      match("[A-Z ]").repeat(1).as(:character_name)
    end

    rule(:character_name) do
      spiral_character_name | no_spiral_character_name
    end

    rule(:speech) do
      (
        match("[a-zA-Z\s\.\(\)\,0-9\?]").repeat(1)
      ).as(:speech)
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
        match("[a-zA-Z\s]").repeat(1) >>
        closing_parenthesis
      ).as(:parenthetical)
    end

    rule(:action) do
      scene_openers.absent? >>
      match("[a-zA-Z\s\.\(\)\,0-9\?\:\-]").repeat(1).as(:action) >>
      line_break.maybe >>
      line_break.maybe
    end

  end
end

